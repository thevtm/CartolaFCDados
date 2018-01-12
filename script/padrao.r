#################################
#################################
### Cartola FC Scraper Padrão ###
#################################
#################################

# LIBS
library(dplyr)
library(tidyr)


# ARGS
PROJECT_PATH = "/.../CartolaFCDados/2016/"


# Clubes
# "ID","Nome","Abreviacao","Slug"

Clubes = tbl_df(read.csv(paste0(PROJECT_PATH, 'Clubes.csv')))

sapply(Clubes, function(y) sum(length(which(is.na(y)))))

write.csv(Clubes, file = paste0(PROJECT_PATH, 'Clubes.csv'), row.names = F)


# Partidas
# "ID","Rodada","CasaID","VisitanteID","PlacarCasa","PlacarVisitante","Resultado"

Partidas = tbl_df(read.csv(paste0(PROJECT_PATH, 'Partidas.csv')))
#Partidas = rename(Partidas, CasaID = Casa, VisitanteID = Visitante)

sapply(Partidas, function(y) sum(length(which(is.na(y)))))

write.csv(Partidas, file = paste0(PROJECT_PATH, 'Partidas.csv'), row.names = F)


# Atletas
# "ID","Apelido","ClubeID","PosicaoID"

Atletas = tbl_df(read.csv(paste0(PROJECT_PATH, 'Atletas.csv')))
#Atletas = rename(Atletas, ClubeID = Clube, PosicaoID = Posicao)

#Atletas = left_join(Atletas, (select(Scouts, AtletaID, ClubeIDNovo = ClubeID) %>% distinct()), by = c("ID" = "AtletaID")) %>%
#  select(ID, Apelido, ClubeID = ClubeIDNovo, PosicaoID)

sapply(Atletas, function(y) sum(length(which(is.na(y)))))

write.csv(Atletas, file = paste0(PROJECT_PATH, 'Atletas.csv'), row.names = F)


# Scouts
# "Rodada","ClubeID","AtletaID","Participou","Pontos","PontosMedia","Preco","PrecoVariacao",
# "FS","PE","A","FT","FD","FF","G","I","PP","RB","FC","GC","CA","CV","SG","DD","DP","GS"

Scouts = tbl_df(read.csv(paste0(PROJECT_PATH, 'Scouts.csv')))

# Scouts = Scouts %>% group_by(AtletaID) %>% arrange(Rodada) %>%
#   mutate(Participou = Jogos > lag(Jogos)) %>%
#   replace_na(list(Participou = FALSE)) %>%
#   ungroup()

# Scouts = Scouts %>%
#   select(Rodada, ClubeID, AtletaID, Participou, Pontos, PontosMedia, Preco, PrecoVariacao,
#          FS, PE, A, FT, FD, FF, G, I, PP, RB, FC, GC, CA, CV, SG, DD, DP, GS)

sapply(Scouts, function(y) sum(length(which(is.na(y)))))

write.csv(Scouts, file = paste0(PROJECT_PATH, 'Scouts.csv'), row.names = F)

