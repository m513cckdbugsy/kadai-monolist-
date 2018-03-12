class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
  end

  def new
    @items = [] #配列

    @keyword = params[:keyword]
    if @keyword.present? # 
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存はしない）
        item = Item.find_or_initialize_by(read(result)) #read(result) のitemが存在する場合は取得(find)※unwant用、存在しなければ新規作成(未保存)
        @items << item  #左辺の配列（レシーバ）の末尾に右辺のオブジェクトを要素として加えます。
      end
    end
  end
end