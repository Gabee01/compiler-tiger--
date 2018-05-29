Esse parser foi criado para a disciplina de Construção de compiladores do curso de Ciência da Computação, na Universidade Federal do Paraná. Professor: André Guedes.

O Objetivo desse projeto é criar um analisador sintático para a linguagem tiger--, uma versão simplificada da linguagem.

Na pasta teste, existem alguns programas tiger-- escritos para teste da análise. Eles estão divididos em subpastas success e error. Os programas em success, devem ser analisados com sucesso pelo analisador sintático, ao contrário dos na pasta error, que devem imprimir uma mensagem de erro na saida padrão ao detectar o mesmo.

Na pasta used-examples existe um exemplo usado como base para o início desse projeto.

Na pasta docs, estão a especificação da linguagem tiger-- disponibilizada pelo professor, e um documento com algumas funções disponíveis do bison.

Foi notado que a generalização dos tokens dificulta a criação da gramática, pois com um token muito genérico (como palavra_reservada, por exemplo) não é possível detectar muitas regras.

Além disso, a ordem com que as regras são definidas é bastante importante. Um ID só pode ser definido depois das palavras reservadas para evitar que toda palavra reservada se torne um token do tipo ID

A criação de um token para número positivo e outro para número negativo foi tomada após notar que analisar o sinal de negativo na gramática complicaria muito a mesma, enquanto com esse token, ela foi simplificada e pode ser facilmente diferenciada durante a redução.

Algumas expressões possuem ; ao seu final, outras não.. Por esse motivo, a regra 'expression: expression T_DOTCOM' foi utilizada. Essa regra simplificou bastante a gramática, porém teve um efeito colateral de que complicou a detecção de erros por falta de ;.

O tipo nulo foi definido como sendo a palavra null. Não lembro de ter encontrado nenhuma definição desse tipo no documento que descreve a linguagem.

Estão sendo identificados como valores apenas: numeros inteiros (positivos e negativos), strings tipos nulos.

A recursão foi bastante utilizada para que fosse possível fazer a analise de regras encadeadas (por exemplo: sequencia de expressões, ou uma expressão aritimética com vários elementos).

Foi interpretado que sequencias não podem ser vazias, e adicionado um erro nesse caso.

Foram detectados erros nos os seguintes casos:
- while sem comparações;
- while sem do;
- sequência vazia;
- if sem then;
