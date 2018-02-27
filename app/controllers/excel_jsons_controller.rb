class ExcelJsonsController < ApplicationController

require 'roo-xls'
require 'json'
require 'fileutils'

  
  def index
  	
	end

  def show
	
  end

  def create
  	# p params[:upload]
		file = params[:upload][:datafile]
		
		name = file.original_filename
		
		
		File.open("/rails/json_app/public/docs/#{name}", 'wb') { |f| f.write(file.read) }
		# result = "#{name}をアップロードしました。"
		
		
		file_path = "/rails/json_app/public/docs/#{name}"
		
		doc = Roo::Excel.new(file_path)

		# 1枚目のシートを使う
		doc.default_sheet = doc.sheets.first

		# 1行目をヘッダ行として列数をカウントする．ヘッダ名をJSONのhash keyにするので空文字はスキップされる

		product_headers = {}
		place_headers = {}

		(doc.first_column..doc.last_column).each do |col|
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
		p "x" 
		p x 
			  if !place_headers[x].nil?
				hash[place_headers[x]] = []
				
				((doc.first_row + 7)..doc.last_row).each do |row|
				p "row"
				p row
					if "○".eql?(doc.cell(row, x+1)) 
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

		end

		
			File.open("public/json/#{name}.json", "w") do |file|
					  	file.puts(hash.to_json)
			end
					
				
	end
	
	
end
