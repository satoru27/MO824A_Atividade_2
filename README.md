# A2_E08

## Equipe
 - Victor Ferreira Ferrari      (187890)
 - Flávio Murilo Reginato       (197088)
 - Vitor Satoru Machi Matsumine (264962)

## Execução do Modelo para 2-TSP

Comando:

``` python3 atividade2.py <NUMBER-OF-CITIES> ```

Este comando cria uma instância, devolve no terminal o resultado da otimização do Gurobi para o 2-TSP e os dois ciclos encontrados.

Também gera um arquivo ```2-tsp_<NUMBER-OF-CITIES>cities.lp``` com as restrições do modelo.


## Execução do Modelo para TSP

Comando:

``` python3 tsp.py <NUMBER-OF-CITIES> ```

O funcionamento é similar ao modelo do 2-TSP, porém não cria um arquivo ```.lp```.

Para ambos programas, a instância gerada depende da _seed_, que está diretamente no código.
