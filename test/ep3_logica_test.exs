defmodule Ep3LogicaTest do
  use ExUnit.Case
  doctest Ep3Logica

  test "Criação do automato" do
    assert Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]], [:Q2], [:a]) == %{
      :current_state => :Q1, 
      :transitions => [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]], 
      :accept_states => [:Q2],
      :tape => %{:left => [:"$"], :right => [:a, :"$"]}
    }
  end

  test "Obter proximos estados" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]], [:Q2], [:a, :b])
    assert Ep3Logica.get_next_states(automato) == [:Q2]
  end

  test "Efetuar step" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]], [:Q2], [:a, :b])
    [next_state] = Ep3Logica.get_next_states(automato)
    novo_automato = Ep3Logica.do_step(automato, next_state) 
    assert novo_automato == %{
      accept_states: [:Q2],
      current_state: :Q2,
      tape: %{left: [:"$", :a], right: [:b, :"$"]},
      transitions: [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]]
    }
  end

  test "Verifica aceitação do automato" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q1], b: [:Q2]]], [:Q2], [:a])
    assert Ep3Logica.is_accepted?(automato) == false
    automato = Ep3Logica.do_step(automato, Ep3Logica.get_next_states(automato) |> List.first())
    assert Ep3Logica.is_accepted?(automato) == true 
  end

  test "Verifica execução de automato deterministico com estado final em aceitação" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q2], b: [:Q2]]], [:Q2], [:a])
    assert Ep3Logica.run_automaton(automato) == true
  end

  test "Verifica execução de automato deterministico com estado final nao aceito" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2], b: [:Q1]], Q2: [a: [:Q2], b: [:Q2]]], [:Q1], [:a])
    assert Ep3Logica.run_automaton(automato) == false
  end

  test "Verifica execução de automato não deterministico com estado final em aceitação" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q1, :Q2], b: [:Q1]], Q2: [a: [:Q2], b: [:Q2]]], [:Q2], [:a])
    assert Ep3Logica.run_automaton(automato) == true
  end

  test "Verifica execução de automato não deterministico com estado final nao aceito" do
    automato = Ep3Logica.create_automaton(:Q1, [Q1: [a: [:Q2, :Q3], b: [:Q2]], Q2: [a: [:Q2], b: [:Q3]], Q3: [a: [:Q2], b: [:Q3]]], [:Q1], [:a, :b])
    assert Ep3Logica.run_automaton(automato) == false
  end
end
