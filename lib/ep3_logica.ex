defmodule Ep3Logica do
  @moduledoc """
  Implementação de um automato finito aceitador de estados deterministico e não deterministico.
  """

  @type state :: atom
  @type action :: atom
  @type transitions :: [{state, [{action, [state]}, ...]}, ...]
  @type tape :: %{:left => [action, ...], :right => [action, ...]}
  @type automaton :: %{:current_state => state, :transitions => transitions, :accept_states => [state, ...], :tape => tape}

  @doc """
  Cria o automato finito
  """
  @spec create_automaton(state, transitions, [state, ...], [action, ...]) :: automaton
  def create_automaton(initial_state, transitions, accept_states, actions) do
    %{
      :current_state => initial_state,
      :transitions => transitions,
      :accept_states => accept_states,
      :tape => Tape.init(actions)
    }
  end

  @doc """
  Retorna uma lista com os possíveis próximos estados do automato.
  """
  @spec get_next_states(automaton) :: [state, ...]
  def get_next_states(automaton)
  def get_next_states(%{:current_state => current_state, :transitions => transitions, :accept_states => _, :tape => tape}) do
    transitions[current_state] 
    |> Enum.filter(fn x -> elem(x, 0) == Tape.at(tape) end) 
    |> hd() 
    |> elem(1)
  end

  @doc """
  Muda o estado do automato para "new_state" e reconfigura sua fita.
  """
  @spec do_step(automaton, state) :: automaton
  def do_step(automaton, new_state)
  def do_step(%{:current_state => _, :transitions => transitions, :accept_states => accept_states, :tape => tape}, new_state) do
    %{
      :current_state => new_state,
      :transitions => transitions,
      :accept_states => accept_states,
      :tape => Tape.reconfig(tape)
    }
  end

  @doc """
  Verifica se o automato se encontra em um estado de aceitação
  """
  @spec is_accepted?(automaton) :: true | false
  def is_accepted?(automaton)
  def is_accepted?(%{:current_state => current_state, :accept_states => accept_states}) do
    Enum.member?(accept_states, current_state)
  end

  @doc """
  Executa o automato finito deterministico ou não deterministico.
  Tratando-se de um automato "aceitador" busca-se um estado final que seja um estado de aceitação. Caso qualquer um dos caminhos gerados
  pela sequência de ações resulte em um estado de aceitação a função retorna true, caso contrário retorna false.
  """
  @spec run_automaton(automaton) :: true | false
  def run_automaton(automaton) do
    if Tape.end?(Map.get(automaton, :tape)) do
      is_accepted?(automaton) 
    else
      # Pega todos os possiveis proximos estados (apenas um para deterministico)
      get_next_states(automaton)
      # Retorna verdadeiro caso algum retorne verdadeiro
      |> Enum.any?(fn next_state -> 
        do_step(automaton, next_state)
        |> run_automaton()
      end)
    end
  end
end

