class Integer
  def to_roman
    RomanNumeral.new(self).value
  end
end

class RomanNumeral
  # Numbr represents an integer number, the roman numeral it
  # maps to, as well as whether that roman can be used as
  # a prefix. Prefixes are numbers that can prefix a
  # higher number and the integer version always start with 1,
  # e.g. I as in IV, or X as in XC
  Numbr = Struct.new(:int, :roman, :prefixable?)

  NUMBERS = {
    0     => Numbr.new(0, "", false),
    1     => Numbr.new(1, "I", true),
    5     => Numbr.new(5, "V", false),
    10    => Numbr.new(10, "X", true),
    50    => Numbr.new(50, "L", false),
    100   => Numbr.new(100, "C", true),
    500   => Numbr.new(500, "D", false),
    1000  => Numbr.new(1000, "M", true)
  }

  def initialize(num)
    @input = num
    # need to know the Numbrs that   
    # are adjacent to the input (above and below),
    # as well as the nearest potential prefix
    set_next_higher_entry
    set_next_lower_entry
    set_next_lower_prefix
  end

  def value
    return NUMBERS[input].roman if exact_match?

    if use_prefix?
      prefix.roman + higher.roman + remainder.to_roman
    else
      lower.roman + remainder.to_roman
    end
  end

  private

  attr_reader :input, :higher, :lower, :prefix

  def exact_match?
    NUMBERS.include?(input)
  end

  def remainder
    if use_prefix?
      input - (higher.int - prefix.int)
    else
      input - lower.int
    end
  end

  def set_next_higher_entry
    _, @higher = NUMBERS.find { |k,v| k >= input }
  end

  def set_next_lower_entry
    _, @lower = reversed_nums.find { |k,v| k <= input } 
  end

  def set_next_lower_prefix
    _, @prefix = reversed_nums.find { |k,v| k <= input &&  v.prefixable? }
  end

  def reversed_nums
    Hash[NUMBERS.to_a.reverse]
  end

  def use_prefix?
    @use_prefix ||= prefix && higher && number_requires_prefix?
  end

  def number_requires_prefix?
    # ex: if num is 48, then higher num is 50 ("L") and prefix is 10 ("X").
    # Since (50-48 <= 10) is true, the prefix is needed and the answer 
    # starts with XL
    (higher.int - input) <= prefix.int
  end
end