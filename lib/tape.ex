defmodule Tape do
  @moduledoc """
  Unidade de comunicação de um automato finito baseado em Teaching Nondeterministic and Universal Automata using Scheme (Christian Wagenknecht and Daniel P Friedman)
  """
  @type action :: atom
  @type tape :: %{:left => [action, ...], :right => [action, ...]}

  @doc """
  Inicializa a fita com uma lista vazia a esquerda e a lista de valores recebidos a direita
  """
  @spec init([action, ...]) :: tape
  def init(actions) do
    %{:left => [:"$"], :right => actions ++ [:"$"]}
  end

  @doc """
  Retorna o primeiro elemento da lista a direita, onde está localizada a "cabeça" de leitura da fita
  """
  @spec at(tape) :: action
  def at(%{:left => _, :right => right}) do
    List.first(right)
  end

  @doc """
  Move a cabeça de leitura uma celula a direita, adicionando o valor movido a lista da esquerda
  """
  @spec reconfig(tape) :: tape
  def reconfig(%{:left => left, :right => right}) do
    {old_head, new_right} = List.pop_at(right, 0)
    new_left = List.insert_at(left, -1, old_head)
    %{:left => new_left, :right => new_right}
  end

  @doc """
  Apresenta o conteúdo da fita
  """
  @spec contents(tape) :: tape
  def contents(tape) do
    tape
  end

  @doc """
  Verifica se é o final da fita comparando com o átomo :"$"
  """
  @spec end?(tape) :: true | false
  def end?(tape) do
    Tape.at(tape) == :"$"
  end
end
