# Ep3Logica

Implementação de um automato finito aceitador deterministico e não deterministico.
[Documentação](http://./doc/index.html)

## Estrutura do automato

O atomato é representado pelo seu estado atual, transições possíveis, estados de aceitação e sua fita (unidade de comunicação).
Estes elementos são transcritos ao programa na forma de um Map.

```
%{
  :current_state => state, 
  :transitions => [state: [action: [state, ...], ...],
  :accept_states => [state, ...],
  :tape => %{:left => [action, ...], :right => [action, ...]}
}
```

## Criação de um automato

Para gerar um automato deve-se utilizar a função `create_automaton(initial_state, transitions, accept_states, actions)` que recebe todos os elementos associados ao automato e retorna o Map correspondente.

## Execução do automato

Após sua criação pode-se executar o automato e verificar sua aceitação, ou seja, verifica se o estado final do automato, após executar todas as possíveis ações na fita, é um estado de aceitação.

Para automatos não deterministicos, isto é, com mais de um posível próximo estado para a mesma ação, todas as possibilidades são testadas, sendo aceito caso qualquer um dos caminhos leve a um estado final de aceitação.


## Exemplo de utilização do programa

No exemplo abaixo roda-se o programa de forma iterativa pelo comando ```iex -S mix``` que deve ser executado no diretório raiz da aplicação.

Cria-se um automato simples com estado inicial `:Q1`, estado de aceitação `:Q2`, apenas uma ação na fita `:a` e transições da seguinte forma:

|    | :a | :b |
|----|----|----|
| Q1 | Q2 | Q1 |
| Q2 | Q2 | Q2 |


Sendo assim o automato inicia no estado `:Q1` e, ao receber `:a` passa ao estado `:Q2` - um estado de aceitação - finalizando sua execução e retornando `true`.

```
  > iex -S mix
  iex(1)> automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q2], b: [:Q2]]], [:Q2], [:a])
  %{
    accept_states: [:Q2],
    current_state: :Q1,
    tape: %{left: [:"$"], right: [:a, :"$"]},
    transitions: [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q2], b: [:Q2]]]
  }
  iex(2)> Ep3Logica.run_automaton(automato)
  true
```

