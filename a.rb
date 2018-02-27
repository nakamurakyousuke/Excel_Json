# encoding: utf-8
# 
# b.rb: Excel -> JSON変換を行う
# 
# usage: ruby b.rb
# 
# description:



require 'roo-xls'
require 'json'
require 'fileutils'

file_path = "./list.xls"


# xlsxではなくxlsファイルを使う時はExcelx -> Excelに変更する
doc = Roo::Excel.new(file_path)

# 1枚目のシートを使う
doc.default_sheet = doc.sheets.first

# 1行目をヘッダ行として列数をカウントする．ヘッダ名をJSONのhash keyにするので空文字はスキップされる
# headers = {}
product_headers = {}
place_headers = {}

(doc.first_column..doc.last_column).each do |col|
#  headers[col] = doc.cell(doc.first_row + 2, col + 1)
  if col <8
   product_headers[col] = doc.cell(doc.first_row + 2, col + 1)
  end
  if col >=8
   place_headers[col] = doc.cell(doc.first_row + 2, col + 1)
	end
end


p product_headers
p place_headers

hash = {}


place_headers.keys.each do |x|
	  if !place_headers[x].nil?
		hash[place_headers[x]] = []
		((doc.first_row + 7)..doc.last_row).each do |row|
		  row_data = {}
		  product_headers.keys.each do |col|
		    	if col == 2
		    		value = doc.cell(row, col)
		    	else
				    value = doc.cell(row, col + 1)
		    	end
			    value = value.to_i if doc.celltype(row, col + 1) == :float && value.modulo(1) == 0.0			     
			    
			    if col == 2
			    	row_data[product_headers[col]] = value.to_s+".jpg"
			    else
			    	row_data[product_headers[col]] = value
			    end
		    end
		    
		    
		    
		  hash[place_headers[x]] << row_data
		  
		 
		
		end
	
	end

end

File.open("./list2.json", "w") do |file|
		  	file.puts(hash.to_json)
end

# puts hash.to_json

