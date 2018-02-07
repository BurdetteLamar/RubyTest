require_relative '../common_requires'

# Class to test class +DebugHelper+.
class DebugHelperTest < MiniTest::Test

  def test_printf

    # Does not verify output; just ensures successful execution.

    hash = {}
    DebugHelper.printf(hash)
    hash = {:a => 0, :b => 1, :c => 2}
    DebugHelper.printf(hash)

    DebugHelper.printf(hash, 'My name', 'My description')

    array = []
    DebugHelper.printf(array)
    array = [:a, :b, :c]
    DebugHelper.printf(array)

    set = Set.new([])
    DebugHelper.printf(set)
    set = Set.new([:a, :b, :c])
    DebugHelper.printf(set)

    DebugHelper.printf(nil)

    DebugHelper.printf('')
    DebugHelper.printf('foo')

    DebugHelper.printf(0)

    DebugHelper.printf(:a)

    DebugHelper.printf(true)

  end

end
