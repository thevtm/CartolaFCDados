# Cartola FC Dados

Repositorio contendo os dados das edições passadas do [Cartola FC](https://cartolafc.globo.com/) obtidos com o [Cartola FC Scraper](https://github.com/thevtm/CartolaFCScraper).

## Estrutura dos Dados

### Posições

- **ID**: ID da posição
- **Nome**: Nome da posição
- **Abreviacao**: Abreviação da posição

### Status

- **ID**: ID do status
- **Nome**: Nome do status

### Clubes

- **ID**: ID do clube
- **Nome**: Nome do clube
- **Abreviacao**: Abreviação do clube
- **Slug**: Slug do clube

### Partidas

- **ID**: ID da partida
- **Rodada**: Rodada em que a partida ocorreu
- **CasaID**: ID do clube mandante
- **VisitanteID**: ID do clube visitante
- **PlacarCasa**: Placar do clube mandante
- **PlacarVisitante**: Placar do clube visitante
- **Resultado**: Resultado final da partida [`"Casa"`, `"Visitante"`, `"Empate"`]

### Atletas

- **ID**: ID do atleta
- **Apelido**: Apelido do atleta
- **ClubeID**: ID do clube do atleta
- **PosicaoID**: ID da posição do atleta

### Scouts

- **Rodada**: Rodada em que o scout ocorreu
- **ClubeID**: ID do clube do atleta
- **AtletaID**: ID do atleta
- **Participou**: `TRUE` se o atleta participou do jogo, `FALSE` se ficou no banco
- **Pontos**: Pontuação do atleta nesta rodada
- **PontosMedia**: Média de pontos do atleta até está rodada (inclue rodada atual)
- **Preco**: Preço do atleta nesta rodada
- **PrecoVariacao**: Variação do preço da rodada passada para está
- **FS**: Faltas sofridas
- **PE**: Passes errados
- **A**: Assistências
- **FT**: Finalizações na trave
- **FD**: Finalizações defendidas
- **FF**: Finalizações para fora
- **G**: Gols
- **I**: Impedimentos
- **PP**: Penaltis perdidos
- **RB**: Roubadas de bola
- **FC**: Faltas cometidas
- **GC**: Gols contras
- **CA**: Cartões Amarelos
- **CV**: Cartões Vermelhos
- **SG**: Jogo sem sofrer gols
- **DD**: Defesas dificeis
- **DP**: Defesa de penaltis
- **GS**: Gols sofridos
