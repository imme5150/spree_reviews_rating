module Spree
  module ReviewsHelper
    def mk_stars(m)
      (1..5).collect {|n| n <= m ? star("lit") : star("unlit") }.join
    end

    def txt_stars(n, show_out_of = true)
      return 'No ratings' unless n
      res = I18n.t('star', :count => n)
      res += ' ' + t('out_of_5') if show_out_of
      res
    end
    
  end
end
