defmodule TapeTest do
  use ExUnit.Case
  doctest Tape

  test "Inicializa uma fita" do
    assert Tape.init([:a, :b, :c]) == %{:left => [:"$"], :right => [:a, :b, :c, :"$"]}
  end

  test "Verifica item na cabeça de leitura" do
    tape = Tape.init([:a, :b])
    assert Tape.at(tape) == :a
  end

  test "Verifica reconfiguração da fita, movendo a cabeça de leitura para a direita" do
    tape = Tape.init([:a, :b])
    new_tape = Tape.reconfig(tape)
    assert Tape.contents(tape) == %{:left => [:"$"], :right => [:a, :b, :"$"]}
    assert Tape.contents(new_tape) == %{:left => [:"$", :a], :right => [:b, :"$"]}

    new_new_tape = Tape.reconfig(new_tape)
    assert Tape.contents(new_new_tape) == %{:left => [:"$", :a, :b], :right => [:"$"]}
  end

  test "Verifica fim da fita" do
    tape = Tape.init([:a])
    assert Tape.end?(tape) == false
    new_tape = Tape.reconfig(tape)
    assert Tape.end?(new_tape) == true
  end
end
