##########################################
##########################################
### Cartola FC Scraper (SQLite) to CSV ###
##########################################
##########################################

# LIBS
library(dplyr)
library(RSQLite)

# ARGS
SQLITE_PATH = "/FULL/PATH/TO/CartolaFCScraperData.sqlite"
OUT_DIR = "/FULL/PATH/TO/OUTPUT/DIRECTORY/"

# Conecta SQLite
con = dbConnect(RSQLite::SQLite(), dbname=SQLITE_PATH)
dbListTables(con)


# Posicao
# "ID","Nome","Abreviacao" 
Posicoes = tbl_df(read.csv(paste0(OUT_DIR, 'Posicoes.csv')))


# Clubes
# "ID","Nome","Abreviacao","Slug"
Clubes = tbl_df(read.csv(paste0(OUT_DIR, 'Clubes.csv')))


# Partidas
# "ID","Rodada","CasaID","VisitanteID","PlacarCasa","PlacarVisitante","Resultado"

partidas = tbl_df(dbGetQuery(con, 'SELECT * FROM Partidas'))

Partidas = partidas %>%
  left_join(select(Clubes, CasaID = ID, Slug), by = c("EquipeMandante" = "Slug")) %>%
  left_join(select(Clubes, VisitanteID = ID, Slug), by = c("EquipeVisitante" = "Slug")) %>%
  arrange(ID) %>%
  select(ID, Rodada, CasaID, VisitanteID, PlacarCasa = PlacarMandante, PlacarVisitante) %>%
  mutate(Resultado = if_else(PlacarCasa > PlacarVisitante, "Casa", if_else(PlacarVisitante > PlacarCasa, "Visitante", "Empate")))

write.csv(Partidas, file = paste0(OUT_DIR, 'Partidas.csv'), row.names = F)


# Atletas
# "ID","Apelido","ClubeID","PosicaoID"

data = tbl_df(dbGetQuery(con, 'SELECT * FROM data'))

Atletas = data %>% select(ID = Atleta, Apelido, Clube, Posicao) %>%
  distinct(ID, .keep_all = T) %>%
  left_join(select(Posicoes, PosicaoID = ID, Abreviacao), by = c('Posicao' = 'Abreviacao')) %>%
  left_join(select(Clubes, ClubeID = ID, Abreviacao), by = c('Clube' = 'Abreviacao')) %>%
  select(ID, Apelido, ClubeID, PosicaoID)

write.csv(Atletas, file = paste0(OUT_DIR, 'Atletas.csv'), row.names = F)


# Scouts
# "Rodada","ClubeID","AtletaID","Jogos","Pontos","PontosMedia","Preco","PrecoVariacao",
# "FS","PE","A","FT","FD","FF","G","I","PP","RB","FC","GC","CA","CV","SG","DD","DP","GS"

data = tbl_df(dbGetQuery(con, 'SELECT * FROM data'))

Scouts = select(data, Rodada, Clube, ClubeID, AtletaID = Atleta, Jogos, Pontos, PontosMedia,
                Preco, PrecoVariacao, FS, PE, A, FT, FD, FF, G, I, PP, RB, FC,
                GC, CA, CV, SG, DD, DP, GS) %>%
  left_join(select(Clubes, ClubeID2 = ID, Abreviacao), by = c('Clube' = 'Abreviacao')) %>%
  mutate(ClubeID = if_else(is.na(ClubeID), ClubeID2, ClubeID)) %>%
  left_join(select(Clubes, ClubeID3 = ID, Slug), by = c('Clube' = 'Slug')) %>%
  mutate(ClubeID = if_else(is.na(ClubeID), ClubeID3, ClubeID)) %>%
  arrange(Rodada, ClubeID, Preco, Jogos, AtletaID) %>%
  select(-Clube, -ClubeID2, -ClubeID3)

Scouts[is.na(Scouts)] <- 0

write.csv(Scouts, file = paste0(OUT_DIR, 'Scouts.csv'), row.names = F)

