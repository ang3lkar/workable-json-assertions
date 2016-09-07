module Minitest
  module Assertions
    ##
    # Returns a diff between +exp+ and +act+. If there is no known
    # diff command or if it doesn't make sense to diff the output
    # (single line, short output), then it simply returns a basic
    # comparison between the two.

    def diff exp, act
      expect = mu_pp_for_diff exp
      butwas = mu_pp_for_diff act
      result = nil

      need_to_diff =
        (expect.include?("\n")    ||
         butwas.include?("\n")    ||
         expect.size > 30         ||
         butwas.size > 30         ||
         expect == butwas)        &&
        Minitest::Assertions.diff

      return "Expected: #{mu_pp exp}\n  Actual: #{mu_pp act}" unless
        need_to_diff

      Tempfile.open("expect") do |a|
        a.puts expect
        a.flush

        Tempfile.open("butwas") do |b|
          b.puts butwas
          b.flush

          result = `#{Minitest::Assertions.diff} #{a.path} #{b.path} | colordiff`
          result.sub!(/^\-\-\- .+/, "--- expected")
          result.sub!(/^\+\+\+ .+/, "+++ actual")

          if result.empty? then
            klass = exp.class
            result = [
                      "No visible difference in the #{klass}#inspect output.\n",
                      "You should look at the implementation of #== on ",
                      "#{klass} or its members.\n",
                      expect,
                     ].join
          end
        end
      end

      result
    end

  end
end
