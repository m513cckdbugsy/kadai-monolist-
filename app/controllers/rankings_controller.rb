class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking #[3=>10, 5=>6, 2=>5, 8=>3, ...] のように [item_id => Want の数]が入る
    @items = Item.find(@ranking_counts.keys) #@ranking_counts.keys でハッシュから item_id だけ取り出す。findした@items はランキングの順番通りの並び順
  end
  def have
    @ranking_counts = Have.ranking #[3=>10, 5=>6, 2=>5, 8=>3, ...] のように [item_id => Have の数]が入る
    @items = Item.find(@ranking_counts.keys) #@ranking_counts.keys でハッシュから item_id だけ取り出す。findした@items はランキングの順番通りの並び順
  end
end
