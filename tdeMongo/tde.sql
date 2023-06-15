use detentos

db.detentos.insertOne({"DetentoId": 1, "Nome": "Leo", "Bloco": "A", "Cela": 3002})

use visitantes
db.visitantes.insertOne({"VisitanteId": 1, "Nome": "Cássio", "Relacionamento": "Professor"})

use visitas
db.visitas.insertOne({"Visitaid":1, "DetentoId":1, "VisitanteId": 1, "DataVisita": "2022-04-1", "HoraEntrada": "20:30", "HoraSaida":"20:55"})

