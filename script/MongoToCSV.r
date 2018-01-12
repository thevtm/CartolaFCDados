# Transforma os dados do MongoDB para CSV

# LIBS

library(mongolite)


# ARGS
DB_ADDRESS = "mongodb://localhost/numeros-do-cartola-2016"
OUT_DIR = "/.../CartolaFCDados/2016/"


# EXEC

## STATUS ##
# 1. Conecta ao MongoDB
con <- mongo("Status", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
status <- con$aggregate(pipeline = '[
  {
    "$project": {
      "_id": false,
      "ID": "$_id",
      "Nome": true
    }
  }
]')

status <- status[c('ID', 'Nome')]

# 3. Salva o CSV
write.csv(status, file = paste0(OUT_DIR, 'Status.csv'), row.names = FALSE)

# 4. Limpa vars
rm(status, con)




## POSIÇÕES ##
# 1. Conecta ao MongoDB
con <- mongo("Posicoes", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
posicoes <- con$aggregate(pipeline = '[
  {
    "$project": {
      "_id": false,
      "ID": "$_id",
      "Nome": true,
      "Abreviacao": true
    }
  }
]')

posicoes <- posicoes[c('ID', 'Nome', 'Abreviacao')]

# 3. Salva o CSV
write.csv(posicoes, file = paste0(OUT_DIR, 'Posicoes.csv'), row.names = FALSE)

# 4. Limpa vars
rm(posicoes, con)




## CLUBES ##
# 1. Conecta ao MongoDB
con <- mongo("Clubes", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
clubes <- con$aggregate(pipeline = '[
  {
    "$project": {
      "_id": false,
      "ID": "$_id",
      "Nome": true,
      "Abreviacao": true,
      "Slug": true
    }
  }
]')

clubes <- clubes[c('ID', 'Nome', 'Abreviacao', 'Slug')]

# 3. Salva o CSV
write.csv(clubes, file = paste0(OUT_DIR, 'Clubes.csv'), row.names = FALSE)

# 4. Limpa vars
rm(clubes, con)




## PARTIDAS ##
# 1. Conecta ao MongoDB
con <- mongo("Partidas", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
partidas <- con$aggregate(pipeline = '[
  {
    "$project": {
      "_id": false,
      "ID": "$_id",
      "Rodada": true,
      "CasaID": "$Casa",
      "VisitanteID": "$Visitante",
      "PlacarCasa": true,
      "PlacarVisitante": true,
      "Resultado": true
    }
  }
]')

partidas <- partidas[c('ID', 'Rodada', 'CasaID', 'VisitanteID', 'PlacarCasa', 'PlacarVisitante', 'Resultado')]

# 3. Salva o CSV
write.csv(partidas, file = paste0(OUT_DIR, 'Partidas.csv'), row.names = FALSE)

# 4. Limpa vars
rm(partidas, con)




## ATLETAS ##
# 1. Conecta ao MongoDB
con <- mongo("Atletas", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
atletas <- con$aggregate(pipeline = '[
  {
    "$project": {
      "_id": false,
      "ID": "$_id",
      "Apelido": true,
      "PosicaoID": "$Posicao",
      "ClubeID": "$Clube"
    }
  }
]')

atletas <- atletas[c('ID', 'Apelido', 'ClubeID', 'PosicaoID')]

# 3. Salva o CSV
write.csv(atletas, file = paste0(OUT_DIR, 'Atletas.csv'), row.names = FALSE)

# 4. Limpa vars
rm(atletas, con)




## SCOUTS ##
# 1. Conecta ao MongoDB
con <- mongo("Atletas", url = DB_ADDRESS)

# 2. Pega e ajusta os dados
scouts <- con$aggregate(pipeline = '[
  {
    "$unwind": "$Scouts"
  },
  {
    "$project": {
      "_id": false,
      "Rodada": "$Scouts.Rodada",
      "ClubeID": "$Scouts.Clube",
      "AtletaID": "$_id",
      "Participou": "$Scouts.Participou",
      "Pontos": "$Scouts.Pontos",
      "PontosMedia": "$Scouts.PontosMedia",
      "Preco": "$Scouts.Preco",
      "PrecoVariacao": "$Scouts.PrecoVariacao",
      "FS": "$Scouts.FS",
      "PE": "$Scouts.PE",
      "A":  "$Scouts.A",
      "FT": "$Scouts.FT",
      "FD": "$Scouts.FD",
      "FF": "$Scouts.FF",
      "G":  "$Scouts.G",
      "I":  "$Scouts.I",
      "PP": "$Scouts.PP",
      "RB": "$Scouts.RB",
      "FC": "$Scouts.FC",
      "GC": "$Scouts.GC",
      "CA": "$Scouts.CA",
      "CV": "$Scouts.CV",
      "SG": "$Scouts.SG",
      "DD": "$Scouts.DD",
      "DP": "$Scouts.DP",
      "GS": "$Scouts.GS"
    }
  }
]')

scouts <- scouts[c('Rodada', 'ClubeID', 'AtletaID', 'Participou', 'Pontos', 'PontosMedia', 'Preco', 'PrecoVariacao',
                   'FS', 'PE', 'A', 'FT', 'FD', 'FF', 'G', 'I', 'PP', 'RB', 'FC', 'GC', 'CA', 'CV', 'SG', 'DD', 'DP', 'GS')]

# 3. Salva o CSV
write.csv(scouts, file = paste0(OUT_DIR, 'Scouts.csv'), row.names = FALSE)

# 4. Limpa vars
rm(scouts, con)
