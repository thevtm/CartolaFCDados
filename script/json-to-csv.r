######################################
######################################
### Cartola FC Scraper JSON to CSV ###
######################################
######################################
#
# cat ./CartolaFC-2017-store.json | jq '[.clubes | .[]]' > ./2017/clubes.json
#

# LIBS
library(dplyr)
library(tidyr)
library(jsonlite)


# ARGS
PROJECT_PATH = "/.../CartolaFCDados/2017/"


# Clubes
# "ID","Nome","Abreviacao","Slug"

Clubes = tbl_df(fromJSON(paste0(PROJECT_PATH, "clubes.json"))) %>%
  rename(ID = id, Nome = nome, Abreviacao = abreviacao, Slug = slug)

sapply(Clubes, function(y) sum(length(which(is.na(y)))))

write.csv(Clubes, file = paste0(PROJECT_PATH, 'Clubes.csv'), row.names = F)

# Partidas
# "ID","Rodada","CasaID","VisitanteID","PlacarCasa","PlacarVisitante","Resultado"

Partidas = tbl_df(fromJSON(paste0(PROJECT_PATH, "partidas.json")))
#Partidas = rename(Partidas, CasaID = Casa, VisitanteID = Visitante)

sapply(Partidas, function(y) sum(length(which(is.na(y)))))

write.csv(Partidas, file = paste0(PROJECT_PATH, 'Partidas.csv'), row.names = F)

# Atletas
# "ID","Apelido","ClubeID","PosicaoID"

Atletas = tbl_df(fromJSON(paste0(PROJECT_PATH, "atletas.json"))) %>%
  select(ID = id, Apelido = apelido, ClubeID = clubeId, PosicaoID = posicaoId)
#Atletas = rename(Atletas, ClubeID = Clube, PosicaoID = Posicao)

#Atletas = left_join(Atletas, (select(Scouts, AtletaID, ClubeIDNovo = ClubeID) %>% distinct()), by = c("ID" = "AtletaID")) %>%
#  select(ID, Apelido, ClubeID = ClubeIDNovo, PosicaoID)

sapply(Atletas, function(y) sum(length(which(is.na(y)))))

write.csv(Atletas, file = paste0(PROJECT_PATH, 'Atletas.csv'), row.names = F)


# Scouts
# "Rodada","ClubeID","AtletaID","Participou","Pontos","PontosMedia","Preco","PrecoVariacao",
# "FS","PE","A","FT","FD","FF","G","I","PP","RB","FC","GC","CA","CV","SG","DD","DP","GS"

Scouts = tbl_df(fromJSON(paste0(PROJECT_PATH, "scouts.json"))) %>%
  select(Rodada = rodada, ClubeID = clubeId, AtletaID = atletaId, Participou = participou,
         Pontos = pontos, PontosMedia = pontosMedia, Preco = preco, PrecoVariacao = precoVariacao,
         FS, PE, A, FT, FD, FF, G, I, PP, RB, FC, GC, CA, CV, SG, DD, DP, GS)

sapply(Scouts, function(y) sum(length(which(is.na(y)))))

write.csv(Scouts, file = paste0(PROJECT_PATH, 'Scouts.csv'), row.names = F)
