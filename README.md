Documentação:

O Assistente_DXC é uma ferramenta de Linha de comando, cujo o objetivo é facilitar a vida dos Analistas que Atuam como terceiro na Aché em geral.
A ferramenta tem como objetivo automatizar alguns trabalhos repetitivos, que somente com executando e escolhendo a sua opção
de serviço, ele já irá resolver os seus problemas.

Bom, logo no começo ao executar, ele solicitará ao analista a executar a ferramenta como Adiministrador, Fazendo com que
o proprio analista, tenha liberdade total de executar comando que o façam toda hora executar como Adm. Como a ferramenta
já estará sendo executada como adm, não haverá nessecidade de ficar toda hora digitando senhas e senhas de adm.

Opçõe disponiveis no menu até o momento:

[1] - Limpar temporarios:

Ele acessa as pastas "%temp%" e "temp" e faz a limpeza de tudo que tiver lá dentro.

[2] - Mover Pasta Common para o Sap logon:

As vezes ao abrir o SAP Logon, a tela dele fica em branco, Sem conter nenhuma informação. Para resolver isso é necessario acessar um caminho na rede e copiar essa pasta e colar no caminho de informaçoes do SAP. Essa opção já resolve isso.

[3] - Remover e Adicionar no Dominio:

Essa opção é em casos de você pegar a maquina fora do dominio e será necessario adicionar, ou em casos de a maquina estar no dominio e voce precisar retirar ela do dominio. Ao Voce escolher essa opção, ele te lista as duas opções para voce escolher qual delas você deseja executar.

[4] - Fazer Backup da maquina:

Essa opção foi a mais dificil de fazer e foi ela que me fez e ta me fazendo migrar para o powershell hahaha. Bom essa opção ela faz o backup da maquina que está rodando o script, porém, ela não faz extamente direto o backup, por conta de como a ache lida com os perfils, existem maquinas que podem ter diversos perfis conectados em uma só maquina, por conta disso eu usei um metodo de colocar os perfis em uma stack e mostrar ela em opções junto da data de modificação e Tamanho em GB (apesar da opção de tamanho em gb não estar imprimindo corretamente). Assim que ele imprime as opções, você escolhe qual das opções você deseja fazer o backup e ao escolher, ele já cria uma pasta no caminho com o mesmo nome do perfil escolhido, após criar, ele acessa a pasta tanto de dest, quanto source e começa a copiar as as pastas necessarias do backup.

COMO EXECUTAR:

Você pode baixar a ferramenta com a opção zip(lembre de verificar se a maquina tem a ferramenta zip ou winrar instalado), após baixar, você extrai a pasta no local que deseja armazenar, depois voce acessa a pasta extraida e excuta o arquivo chamado layout.bat. Logo como o seu usuario(tem que ser usuario com permissão de adm), agora é só começar a usar.
