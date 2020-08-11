extends Node2D
#hi

class Level:
	var corridors
	var corridors_count = 0
	
	var boss_rooms
	var boss_rooms_count = 0
	
	var special_rooms
	var special_count = 0
	
	var start_room
	
	func _init(var cor,bosr,special,start):
		corridors 	  = cor
		boss_rooms 	  = bosr
		special_rooms = special
		start_room    = start
		
class room:
	
	var id
	
	var topleft
	var botright
	var width
	var height
	var width2
	var height2
	var z
	var s
	var center
	var bad = 1
	
	var type = 0
	
	func _init(var x1,y1,zpos,w,h,idd,tp):
		z = zpos
		s = w*h
		width = w
		height = h
		width2 = w/2
		height2 = h/2
		
		center = Vector2(x1+width2,y1+height2)
		topleft = Vector2(x1,y1)
		botright = Vector2(x1+w,y1+h)
		id = idd
		type = tp
		
func get_random_cooridnate_on_circlechunk(chunk_number,current_layer,height,width,center_spacing,random_spacing):
	if chunk_number >= 0 and chunk_number <= current_layer:
		chunk_number = current_layer-chunk_number
		var x = rand_range( -chunk_number*width*center_spacing-width*random_spacing, -chunk_number*width*center_spacing+width*2  )
		var y = rand_range( -current_layer*height*center_spacing-height*random_spacing, -current_layer*height*center_spacing+height*2 )
		return Vector2(x,y)
	if chunk_number>current_layer and chunk_number<=2*current_layer:
		chunk_number-= current_layer
		var x = rand_range(  chunk_number*width*center_spacing-width*random_spacing, chunk_number*width*center_spacing+width*random_spacing  )
		var y = rand_range( -current_layer*height*center_spacing-height*random_spacing, -current_layer*height*center_spacing+height*random_spacing )
		return Vector2(x,y)
		
	if chunk_number>2*current_layer and chunk_number<=3*current_layer:
		chunk_number = current_layer*3-chunk_number
		var x = rand_range(  current_layer*width*center_spacing-width*random_spacing, current_layer*width*center_spacing+width*random_spacing )
		var y = rand_range( -chunk_number*height*center_spacing-height*random_spacing, -chunk_number*height*center_spacing+height*random_spacing  )
		return Vector2(x,y)
	if chunk_number>3*current_layer and chunk_number<4*current_layer:
		chunk_number -= current_layer*3
		var x = rand_range(  current_layer*width*center_spacing-width*random_spacing, current_layer*width*center_spacing+width*random_spacing )
		var y = rand_range( chunk_number*height*center_spacing-height*random_spacing, chunk_number*height*center_spacing+height*random_spacing  )
		return Vector2(x,y)
		
	if chunk_number>=4*current_layer and chunk_number<=5*current_layer:
		chunk_number = current_layer*5-chunk_number
		var x = rand_range( chunk_number*width*center_spacing-width*random_spacing, chunk_number*width*center_spacing+width*random_spacing  )
		var y = rand_range( current_layer*height*center_spacing-height*random_spacing, current_layer*height*center_spacing+height*random_spacing )
		return Vector2(x,y)
	if chunk_number>5*current_layer and chunk_number<=6*current_layer:
		chunk_number-= current_layer*5
		var x = rand_range( -chunk_number*width*center_spacing-width*random_spacing, -chunk_number*width*center_spacing+width*random_spacing  )
		var y = rand_range( current_layer*height*center_spacing-height*random_spacing, current_layer*height*center_spacing+height*random_spacing )
		return Vector2(x,y)
		
	if chunk_number>6*current_layer and chunk_number<=7*current_layer:
		chunk_number = current_layer*7-chunk_number
		var x = rand_range( -current_layer*width*center_spacing-width*random_spacing, -current_layer*width*center_spacing+width*random_spacing )
		var y = rand_range( chunk_number*height*center_spacing-height*random_spacing, chunk_number*height*center_spacing+height*random_spacing  )
		return Vector2(x,y)
	if chunk_number>7*current_layer and chunk_number<8*current_layer:
		chunk_number -= current_layer*7
		var x = rand_range( -current_layer*width*center_spacing-width*random_spacing, -current_layer*width*center_spacing+width*random_spacing )
		var y = rand_range( -chunk_number*height*center_spacing-height*random_spacing, -chunk_number*height*center_spacing+height*random_spacing  )
		return Vector2(x,y)
		
func create_rooms_chunk(z,width,height,boss_rooms_number,bwidth,bheight,poirooms_chance,pwidth,pheight):
	var level = Level.new([],[],[],room.new(-10,-10,1,20,20,0,'Start'))
	var room_id = 1
	#room.new(coord[0],coord[1],randi()%z[0]+z[1],randi()%pwidth[0]+pwidth[1],randi()%pheight[0]+pheight[1],i)
	
	var layer_count = boss_rooms_number/2+boss_rooms_number%2
	var chunk_count
	var bossroom_chunks = []
	var non_blocked_chunks  = [0,1,2,3,4,5,6,7]
	var index
	
	var bossroom_created = 0
	var flag
	var temp1
	var temp2
	var next_layer
	var next_layer_chunk_count
	var coeff
	
	var coord
	var boss_room_spawned
	var chance 
	
	for current_layer in range(1,layer_count+1):
		chunk_count = 8 * current_layer
		next_layer = current_layer+1
		next_layer_chunk_count = 8*next_layer
		bossroom_chunks = []
		bossroom_chunks.append(non_blocked_chunks[randi()%(len(non_blocked_chunks))])
		bossroom_created+=1
		
		if bossroom_created<boss_rooms_number:
			index = non_blocked_chunks.find(bossroom_chunks[0])
			for i in range(2):
				if index != len(non_blocked_chunks)-1:
					if non_blocked_chunks[index] == 0:
						if non_blocked_chunks[index+1] == 1:
							non_blocked_chunks.remove(index+1)
					elif non_blocked_chunks[index] == chunk_count-1:
						if non_blocked_chunks[index+1] == 0:
							non_blocked_chunks.remove(index+1)
					else:
						if non_blocked_chunks[index+1]-1 == non_blocked_chunks[index]:
							non_blocked_chunks.remove(index+1)
				else:
					if non_blocked_chunks[index] == 0:
						if non_blocked_chunks[0] == 1:
							non_blocked_chunks.pop_front()
							index-=1
					elif non_blocked_chunks[index] == chunk_count-1:
						if non_blocked_chunks[0] == 0:
							non_blocked_chunks.pop_front()
							index-=1
					else:
						if non_blocked_chunks[0]-1 == non_blocked_chunks[index]:
							non_blocked_chunks.pop_front()
							index-=1
				if index != 0:
					if non_blocked_chunks[index] == 0:
						if non_blocked_chunks[index-1] == chunk_count-1:
							non_blocked_chunks.remove(index-1)
							index-=1
					elif non_blocked_chunks[index] == chunk_count-1:
						if non_blocked_chunks[index-1] == 0:
							non_blocked_chunks.remove(index-1)
							index-=1
					else:
						if non_blocked_chunks[index-1]+1 == non_blocked_chunks[index]:
							non_blocked_chunks.remove(index-1)
							index-=1
				else:
					if non_blocked_chunks[index] == 0:
						if non_blocked_chunks[len(non_blocked_chunks)-1] == chunk_count-1:
							non_blocked_chunks.pop_back()
					elif non_blocked_chunks[index] == chunk_count-1:
						if non_blocked_chunks[len(non_blocked_chunks)-1] == 0:
							non_blocked_chunks.pop_back()
					else:
						if non_blocked_chunks[len(non_blocked_chunks)-1]+1 == non_blocked_chunks[index]:
							non_blocked_chunks.pop_back()
			
			non_blocked_chunks.remove(index)
					
			bossroom_chunks.append(non_blocked_chunks[randi()%(len(non_blocked_chunks))])
			bossroom_created+=1	
			
			#print(bossroom_chunks)
			
			non_blocked_chunks.clear()
			for i in range(next_layer_chunk_count):
				non_blocked_chunks.append(i)
			
			for chunk in bossroom_chunks:
				if chunk == 0:
					coeff = 0
				elif chunk > 0 and chunk < 2*current_layer:
					coeff = 1
				elif chunk == 2*current_layer:
					coeff = 2
				elif chunk > 2*current_layer and chunk < 4*current_layer:
					coeff = 3
				elif chunk == 4*current_layer:
					coeff = 4
				elif chunk > 4*current_layer and chunk < 6*current_layer:
					coeff = 5
				elif chunk == 6*current_layer:
					coeff = 6
				elif chunk > 6*current_layer and chunk < next_layer_chunk_count-1:
					coeff = 7		
				for k in range(0,next_layer_chunk_count/4-1):
					temp1 = chunk + coeff - k
					temp2 = chunk + coeff + k
					if temp1 < 0:
						temp1 += next_layer_chunk_count
					if temp2 >= next_layer_chunk_count:
						temp2 -= next_layer_chunk_count

					index = non_blocked_chunks.find(temp1)
					if index!=-1:
						non_blocked_chunks.remove(index)
					index = non_blocked_chunks.find(temp2)
					if index!=-1:
						non_blocked_chunks.remove(index)
						
		for i in range(chunk_count):
			boss_room_spawned = 0
			for j in bossroom_chunks:
				if i == j:
					coord = get_random_cooridnate_on_circlechunk(i,current_layer,bheight[0],bwidth[0],3,1)
					level.boss_rooms.append(room.new(int(coord.x),int(coord.y),randi()%z[0]+z[1],randi()%bwidth[0]+bwidth[1],randi()%bheight[0]+bheight[1],room_id,'Boss'))
					level.boss_rooms_count+=1
					room_id+=1
					boss_room_spawned = 1
			if boss_room_spawned == 0:
				chance = rand_range(0,1)
				#if chance<=(poirooms_chance+current_layer/40.0):
				#if chance<=(poirooms_chance+log(current_layer)):
				if chance<=(poirooms_chance+(1/3+4*exp(-current_layer))):
					coord = get_random_cooridnate_on_circlechunk(i,current_layer,bheight[0],bwidth[0],3,1)
					level.special_rooms.append(room.new(int(coord.x),int(coord.y),randi()%z[0]+z[1],randi()%pwidth[0]+pwidth[1],randi()%pheight[0]+pheight[1],room_id,'Special_'))
					level.special_count+=1
					room_id+=1
					#chance = rand_range(0,1)
					#if chance<=(poirooms_chance/5.0+current_layer/45.0):
					#	coord = get_random_cooridnate_on_circlechunk(i,current_layer,bheight[0],bwidth[0],6,2)
					#	level.special_rooms.append(room.new(int(coord.x),int(coord.y),randi()%z[0]+z[1],randi()%pwidth[0]+pwidth[1],randi()%pheight[0]+pheight[1],i))
					
		#print("Chances: ",poirooms_chance+current_layer/40.0,' / ', poirooms_chance/5.0+current_layer/45.0)
	return level
	
func circum_circle_contains(points,triangle,vertex):
	var p1 = points[triangle[0]]
	var p2 = points[triangle[1]]
	var p3 = points[triangle[2]]
	
	var ab = p1.center.x * p1.center.x + p1.center.y * p1.center.y
	var cd = p2.center.x * p2.center.x + p2.center.y * p2.center.y
	var ef = p3.center.x * p3.center.x + p3.center.y * p3.center.y
	
	var circum = Vector2( (ab * (p3.center.y - p2.center.y) + cd * (p1.center.y - p3.center.y) + ef * (p2.center.y - p1.center.y)) / (p1.center.x * (p3.center.y - p2.center.y) + p2.center.x * (p1.center.y - p3.center.y) + p3.center.x * (p2.center.y - p1.center.y)),(ab * (p3.center.x - p2.center.x) + cd * (p1.center.x - p3.center.x) + ef * (p2.center.x - p1.center.x)) / (p1.center.y * (p3.center.x - p2.center.x) + p2.center.y * (p1.center.x - p3.center.x) + p3.center.y * (p2.center.x - p1.center.x)))
	
	circum*=0.5
	
	var r = p1.center.distance_squared_to(circum);
	var d = points[vertex].center.distance_squared_to(circum);
	
	return d <= r

func edge_compare(points,edge1,edge2):
	if points[edge1[0]].center.is_equal_approx(points[edge2[0]].center) and points[edge1[1]].center.is_equal_approx(points[edge2[1]].center):
		return true

	if points[edge1[0]].center.is_equal_approx(points[edge2[1]].center) and points[edge1[1]].center.is_equal_approx(points[edge2[0]].center):
		return true
		
	return false
	
func triangulate(points):
	var triangles = []

	points.append( room.new( 0,20000,2,2,2, 10000,'Error' ) )
	points.append( room.new( -20000,-20000,2,2,2, 10000,'Error' ) )
	points.append( room.new( 20000,-20000,2,2,2, 10000,'Error' ) )
	triangles.append([len(points)-3,len(points)-2,len(points)-1,0])
	
	for i in range(len(points)-3):
		
		var polygon = []
		
		for j in range(len(triangles)):
			if circum_circle_contains(points,triangles[j],i):
				triangles[j][3]= true
				polygon.append([triangles[j][0], triangles[j][1],0])
				polygon.append([triangles[j][1], triangles[j][2],0])
				polygon.append([triangles[j][2], triangles[j][0],0])
				
				
		var j = 0
		var ln = len(triangles)
		while j<ln:
			if triangles[j][3]:
				triangles.remove(j)
				j-=1
				ln-=1
			j+=1
		
		for j in range(len(polygon)):
			for k in range(j+1,len(polygon)):
				if edge_compare(points,polygon[j],polygon[k]):
					polygon[j][2]= true
					polygon[k][2]= true
					
		for j in range(len(polygon)):
			if polygon[j][2]:
				continue
				
			triangles.append([polygon[j][0], polygon[j][1], i,0])
	
	var i = 0
	var ln = len(triangles)
	while i<ln:
		var invalid = false
		for j in range(3):
			if triangles[i][j] >= (len(points)-3):
				invalid = true
				break
		if invalid:
			triangles.remove(i)
			i-=1
			ln-=1
		i+=1
	
	return triangles
			
func find(subsets,i):
	if subsets[i][0] != i:
		subsets[i][0] = find(subsets, subsets[i][0])
	return subsets[i][0]
	
func union(subsets,x,y) -> void:
	var xroot = find(subsets,x)
	var yroot = find(subsets,y)
	
	if subsets[xroot][1] < subsets[yroot][1]:
		subsets[xroot][0] = yroot
	elif subsets[xroot][1] > subsets[yroot][1]:
		subsets[yroot][0] = xroot;
	else:
		subsets[yroot][0] = xroot
		subsets[xroot][1] += 1
		
func compare_edges(a,b):
	return a[2]>b[2]
	
func edge_sort(a,b):
	return a[0] > b[0]
	
func not_present(array,id):
	var present = 1
	for i in array:
		if id == i[3]:
			present = 0
	return present

func kruskalmst(points,triangles):
	var nodes = []

	var subsets = []
	
	var result = []
	
	var edge_id = 0
	
	for tri in triangles:
		if not_present(nodes,edge_id):
			nodes.append([tri[0],tri[1],points[tri[0]].center.distance_squared_to(points[tri[1]].center),edge_id])
			edge_id+=1
		if not_present(nodes,edge_id):
			nodes.append([tri[1],tri[2],points[tri[1]].center.distance_squared_to(points[tri[2]].center),edge_id])
			edge_id+=1
		if not_present(nodes,edge_id):
			nodes.append([tri[2],tri[0],points[tri[2]].center.distance_squared_to(points[tri[0]].center),edge_id])
			edge_id+=1
		
	var vertexes = len(points)
	var edges = len(nodes)
		
	var e = 0
	var i = 0
	
	nodes.sort_custom(self,"edge_sort")
	
	for v in range(vertexes):
		subsets.append([v,0])
		
	while e<vertexes-1 and i<edges:
		var next_edge = nodes[i]
		i+=1
		var x = find(subsets,next_edge[0])
		var y = find(subsets,next_edge[1])
	
		if x!=y:
			#print(next_edge)
			result.append(next_edge)
			e+=1
			union(subsets,x,y)
			
	for i in range(round(len(nodes)*0.08)):
		#var trig = triangles[randi()%len(triangles)]
		#result.append([trig[0],trig[1]])
		#print(triangles[randi()%len(triangles)])
		var trig = triangles[randi()%len(triangles)]
		result.append([trig[0],trig[1]])
			
	return result
	
func create_paths(rooms,edges):
	var paths = []
	var room1
	var room2
	
	var room1_pos_x
	var room1_pos_y
	var room2_pos_x
	var room2_pos_y
	
	for edge in edges:
		room1 = rooms[edge[0]]
		room2 = rooms[edge[1]]
		
		if room1.width>6:
			room1_pos_x = room1.center.x+int(rand_range(-room1.width2+1,room1.width2-1))
		if room1.height>6:
			room1_pos_y = room1.center.y+int(rand_range(-room1.height2+1,room1.height2-1))
		
		if room1.width>6:
			room2_pos_x = room2.center.x+int(rand_range(-room2.width2+1,room2.width2-1))
		if room1.height>6:
			room2_pos_y = room2.center.y+int(rand_range(-room2.height2+1,room2.height2-1))
		
		if room1_pos_y<=room2_pos_y:
			
			if room1_pos_x<=room2_pos_x:
				
				if (room2_pos_x-room1_pos_x)<(room2_pos_y-room1_pos_y):
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room2_pos_x,room1_pos_y),Vector2(room2_pos_x,room2_pos_y)])
				else:
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room1_pos_x,room2_pos_y),Vector2(room2_pos_x,room2_pos_y)])
			
			else:
				
				if (room1_pos_x-room2_pos_x)<(room2_pos_y-room1_pos_y):
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room1_pos_x,room2_pos_y),Vector2(room2_pos_x,room2_pos_y)])
				else:
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room2_pos_x,room1_pos_y),Vector2(room2_pos_x,room2_pos_y)])
				
		else:
			
			if room1_pos_x<=room2_pos_x:

				if (room2_pos_x-room1_pos_x)<(room1_pos_y-room2_pos_y):
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room1_pos_x,room2_pos_y),Vector2(room2_pos_x,room2_pos_y)])
				else:
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room2_pos_x,room1_pos_y),Vector2(room2_pos_x,room2_pos_y)])
			
			else:

				if (room1_pos_x-room2_pos_x)<(room2_pos_y-room1_pos_y):
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room2_pos_x,room1_pos_y),Vector2(room2_pos_x,room2_pos_y)])
				else:
					paths.append([Vector2(room1_pos_x,room1_pos_y),Vector2(room1_pos_x,room2_pos_y),Vector2(room2_pos_x,room2_pos_y)])
		
#		if room1.width>6:
#			room1_pos_x = room1.center.x+int(rand_range(-room1.width2+1,room1.width2-1))
#		if room1.height>6:
#			room1_pos_y = room1.center.y+int(rand_range(-room1.height2+1,room1.height2-1))
#
#		if room1.width>6:
#			room1_pos_x = room1.center.x+int(rand_range(-room1.width2+1,room1.width2-1))
#		if room1.height>6:
#			room1_pos_y = room1.center.y+int(rand_range(-room1.height2+1,room1.height2-1))
#
#		if room1.center.y<=room2.center.y:
#
#			if room1.center.x<=room2.center.x:
#
#				if (room2.center.x-room1.center.x)<(room2.center.y-room1.center.y):
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room2.center.x,room1.center.y),Vector2(room2.center.x,room2.center.y)])
#				else:
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room1.center.x,room2.center.y),Vector2(room2.center.x,room2.center.y)])
#
#			else:
#
#				if (room1.center.x-room2.center.x)<(room2.center.y-room1.center.y):
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room1.center.x,room2.center.y),Vector2(room2.center.x,room2.center.y)])
#				else:
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room2.center.x,room1.center.y),Vector2(room2.center.x,room2.center.y)])
#
#		else:
#
#			if room1.center.x<=room2.center.x:
#
#				if (room2.center.x-room1.center.x)<(room1.center.y-room2.center.y):
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room1.center.x,room2.center.y),Vector2(room2.center.x,room2.center.y)])
#				else:
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room2.center.x,room1.center.y),Vector2(room2.center.x,room2.center.y)])
#
#			else:
#
#				if (room1.center.x-room2.center.x)<(room2.center.y-room1.center.y):
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room2.center.x,room1.center.y),Vector2(room2.center.x,room2.center.y)])
#				else:
#					paths.append([Vector2(room1.center.x,room1.center.y),Vector2(room1.center.x,room2.center.y),Vector2(room2.center.x,room2.center.y)])
#		pos = -1
#
#		if room1.center.y<room2.center.y:
#			if room1.botright.y<=room2.topleft.y:
#
#				if room1.botright.x<=room2.topleft.y:
#					pos = 0
#
#				elif room1.topleft.x>=room2.topleft.x:
#					pos = 5
#
#		if pos == -1: print("Wrong pos conditions!")
#
#		if pos == 0:
#			if (room2.center.x-room1.center.x)>(room2.center.y-room1.center.y):
#				room1_connection = Vector2(room1.botright.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#				room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.topleft.y)
#				paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
#			else:
#				room1_connection = Vector2(int(rand_range(room1.topleft.x+2,room1.botright.x-2)),room1.botright.y)
#				room2_connection = Vector2(room2.topleft.x,int(rand_range(room2.topleft.y+2,room2.botright.y-2)))
#				paths.append([room1_connection,Vector2(room1_connection.x,room2_connection.y),room2_connection])
#
#		if pos == 1:
#			if (room1.center.x-room2.center.x)>(room2.center.y-room1.center.y):
#				room1_connection = Vector2(room1.topleft.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#				room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.topleft.y)
#				paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
#			else:
#				room1_connection = Vector2(int(rand_range(room1.topleft.x+2,room1.botright.x-2)),room1.botright.y)
#				room2_connection = Vector2(room2.botright.x,int(rand_range(room2.topleft.y+2,room2.botright.y-2)))
#				paths.append([room1_connection,Vector2(room1_connection.x,room2_connection.y),room2_connection])
#
#		if room1.center.y<room2.center.y:
#			if room1.botright.y-2<=room2.topleft.y:
#
#				if room1.botright.x<=room2.topleft.x:
#					room1_connection = Vector2(room1.botright.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#					room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.topleft.y)
#					paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
#
#				elif room1.topleft.x>=room2.botright.x:
#					room1_connection = Vector2(room1.topleft.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#					room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.topleft.y)
#					paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
#			else:
#				if room1.topleft.y<=room2.topleft.y:
#					if room1.botright.x<=room2.topleft.x:
#						linear_con = int(rand_range(room2.topleft.y,room1.botright.y))
#						room1_connection = Vector2(room1.botright.x,linear_con)
#						room2_connection = Vector2(room2.topleft.x,linear_con)
#						paths.append([room1_connection,room2_connection])
#					elif room1.topleft.x>=room2.botright.x:
#						linear_con = int(rand_range(room2.topleft.y,room1.botright.y))
#						room1_connection = Vector2(room1.topleft.x,linear_con)
#						room2_connection = Vector2(room2.botright.x,linear_con)
#						paths.append([room1_connection,room2_connection])
#				else:
#					if room1.botright.x<=room2.topleft.x:
#						linear_con = int(rand_range(room1.topleft.y,room1.botright.y))
#						room1_connection = Vector2(room1.botright.x,linear_con)
#						room2_connection = Vector2(room2.topleft.x,linear_con)
#						paths.append([room1_connection,room2_connection])
#					elif room1.topleft.x>=room2.botright.x:
#						linear_con = int(rand_range(room1.topleft.y,room1.botright.y))
#						room1_connection = Vector2(room1.topleft.x,linear_con)
#						room2_connection = Vector2(room2.botright.x,linear_con)
#						paths.append([room1_connection,room2_connection])
#
#		elif room1.center.y>room2.center.y:
#			if room1.topleft.y>room2.botright.y:
#
#				if room1.botright.x<=room2.topleft.x:
#					room1_connection = Vector2(room1.botright.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#					room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.botright.y)
#					paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
#
#				elif room1.topleft.x>=room2.botright.x:
#					room1_connection = Vector2(room1.topleft.x,int(rand_range(room1.topleft.y+2,room1.botright.y-2)))
#					room2_connection = Vector2(int(rand_range(room2.topleft.x+2,room2.botright.x-2)),room2.botright.y)
#					paths.append([room1_connection,Vector2(room2_connection.x,room1_connection.y),room2_connection])
				
	
	return paths

func overlap(a,b):
	return a.topleft.x<b.botright.x and a.botright.x>b.topleft.x and a.topleft.y<b.botright.y and a.botright.y>b.topleft.y

func spread(rooms,max_rooms) -> void:
	var overlaped = true
	var x_move
	var y_move
	while overlaped:
		overlaped = false
		for i in range(max_rooms):
			x_move = 0
			y_move = 0
			var cur_room = rooms[i]
			for k in range(max_rooms):
				if k!=i:
					if overlap(cur_room,rooms[k]) and cur_room.type == 'Corridor':
						if cur_room.center.x<rooms[k].center.x: x_move-=1
						else: x_move+=1
						if cur_room.center.y<rooms[k].center.y: y_move-=1
						else: y_move+=1
						overlaped = true
			#move(rooms[i],x_move,y_move)
			cur_room.topleft.x+=x_move
			cur_room.topleft.y+=y_move
			cur_room.botright.x+=x_move
			cur_room.botright.y+=y_move
			cur_room.center.x = cur_room.topleft.x+cur_room.width2
			cur_room.center.y = cur_room.topleft.y+cur_room.height2

func create_physical_paths(paths,width,height,id_start):
	var corridors = []
	var corridors_batch = []
	var corridors_count = 0
	var corridors_batch_count = 0
	var w
	var h
	var index
	for path in paths:
		corridors_batch_count = 0
		corridors_batch = []
		for i in range(2): # path line count
			if path[i].x == path[i+1].x:
				if path[i].y<path[i+1].y:
					for y in range(path[i].y,path[i+1].y,6):
						w = randi()%width[0]+width[1]
						h = randi()%height[0]+height[1]
						corridors_batch.append(room.new(path[i].x-w/2+randi()%8+1,y,1,w,h,id_start+corridors_count,"Corridor"))
						corridors_batch_count+=1
				else:
					for y in range(path[i+1].y,path[i].y,6):
						w = randi()%width[0]+width[1]
						h = randi()%height[0]+height[1]
						corridors_batch.append(room.new(path[i].x-w/2+randi()%8+1,y,1,w,h,id_start+corridors_count,"Corridor"))
						corridors_batch_count+=1
			else:
				if path[i].x<path[i+1].x:
					for x in range(path[i].x,path[i+1].x,6):
						w = randi()%width[0]+width[1]
						h = randi()%height[0]+height[1]
						corridors_batch.append(room.new(x,path[i].y-h/2+randi()%8+1,1,w,h,id_start+corridors_count,"Corridor"))
						corridors_batch_count+=1
				else:
					for x in range(path[i+1].x,path[i].x,6):
						w = randi()%width[0]+width[1]
						h = randi()%height[0]+height[1]
						corridors_batch.append(room.new(x,path[i].y-h/2+randi()%8+1,1,w,h,id_start+corridors_count,"Corridor"))
						corridors_batch_count+=1	
						
		spread(corridors_batch,corridors_batch_count)

		index = 0
		while index<corridors_batch_count:
			for i in range(2): #path lines count
				if path[i].y == path[i+1].y:
					if corridors_batch[index].topleft.y<=path[i].y+1 and corridors_batch[index].botright.y>=path[i].y-1:
						if ( (path[i].x<path[i+1].x and path[i].x-1<=corridors_batch[index].topleft.x and path[i+1].x+1>=corridors_batch[index].botright.x) or (path[i].x>path[i+1].x and path[i].x+1>=corridors_batch[index].botright.x and path[i+1].x-1<=corridors_batch[index].topleft.x) ):
							corridors_batch[index].bad = 0
				else:
					if corridors_batch[index].botright.x>=path[i].x-1 and corridors_batch[index].topleft.x<=path[i].x+1:
						if ( (path[i].y<path[i+1].y and path[i].y-1<=corridors_batch[index].topleft.y and path[i+1].y+1>=corridors_batch[index].botright.y) or (path[i].y>path[i+1].y and path[i].y+1>=corridors_batch[index].botright.y and path[i+1].y-1<=corridors_batch[index].topleft.y) ):
							corridors_batch[index].bad = 0
			if corridors_batch[index].bad == 1:
				corridors_batch.remove(index)
				index-=1
				corridors_batch_count-=1
			else:
				corridors_batch[index].bad = 1
			index+=1

		corridors_count+=corridors_batch_count
		corridors+=corridors_batch
		
	spread(corridors,corridors_count)
	index = 0
	while index<corridors_count:
		for path in paths:
			for i in range(2): #path lines count
				if path[i].y == path[i+1].y:
					if corridors[index].topleft.y<=path[i].y+1 and corridors[index].botright.y>=path[i].y-1:
						if ( (path[i].x<path[i+1].x and path[i].x-1<=corridors[index].topleft.x and path[i+1].x+1>=corridors[index].botright.x) or (path[i].x>path[i+1].x and path[i].x+1>=corridors[index].botright.x and path[i+1].x-1<=corridors[index].topleft.x) ):
							corridors[index].bad = 0
				else:
					if corridors[index].botright.x>=path[i].x-1 and corridors[index].topleft.x<=path[i].x+1:
						if ( (path[i].y<path[i+1].y and path[i].y-1<=corridors[index].topleft.y and path[i+1].y+1>=corridors[index].botright.y) or (path[i].y>path[i+1].y and path[i].y+1>=corridors[index].botright.y and path[i+1].y-1<=corridors[index].topleft.y) ):
							corridors[index].bad = 0
		if corridors[index].bad == 1:
			corridors.remove(index)
			index-=1
			corridors_count-=1
		index+=1
			
	return [corridors,corridors_count]

func delete_overlaped_with_origin(rooms,corridors,corridors_count):
	var index = 0
	while index<corridors_count:
		for room in rooms:
			if overlap(room,corridors[index]):
				corridors.remove(index)
				index-=1
				corridors_count-=1
		index+=1
		
func bitmask_get_cell(node,x,y,type,wall_range,floor_range,debug):
	#var sides = [[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]]
	var sides = [[0,-1],[1,0],[0,1],[-1,0], [-1,-1], [1,-1], [1,1], [-1,1]]
	var cell = node.get_cell(x,y)
	var powertwo = [1,2,4,8,16,32,64,128]
	var power = 0
	var mask = 0
	
	var correct_cell = cell
	var offset
	
	if type == 'wall':
		
		if cell!= -1:
			offset = ( cell / 19 ) * 19
		for side in sides:
			cell = node.get_cell(x+side[0],y+side[1])
			if cell<=wall_range[0] and cell>=wall_range[1]:
				mask+=powertwo[power]
			power+=1
		
		if debug == 1:
			print(mask,' ',offset)
		
		# 5 21 37 69 133 53 197 85 165 181 117 229 213 245 
		if mask == 5 or mask == 21 or mask == 37 or mask == 69 or mask == 133 or mask == 53 or mask == 197 or mask == 85 or mask == 165 or mask == 181 or mask == 117 or mask == 229 or mask == 213 or mask == 245: # vertical line
			correct_cell = 5+offset
			
		# 10 138 26 42 74 106 154 90 170 186 218 234 122 250
		elif mask == 10 or mask == 138 or mask == 26 or mask == 42 or mask == 74 or mask == 106 or mask == 154 or mask == 90 or mask == 170 or mask == 186 or mask == 218 or mask == 234 or mask == 122 or mask == 250: # horisontal line
			correct_cell = 6+offset
		
		else:
			correct_cell = offset
	
	return correct_cell
		
func set_cell_autotile(node,x,y,cell,type,wall_range,floor_range,debug):
	var sides = [[0,-1],[1,0],[0,1],[-1,0], [-1,-1], [1,-1], [1,1], [-1,1]]
	var cell_side
	var cell_side_correct
	
	node.set_cell(x,y,cell)
	cell_side_correct = bitmask_get_cell(node,x,y,type,wall_range,floor_range,debug)
	if cell!=cell_side_correct:
		#print(cell, cell_side_correct)
		node.set_cell(x,y,cell_side_correct)


	for side in sides:
		cell_side = node.get_cell(x+side[0],y+side[1])
		if cell_side == -1:
			continue
		else:
			if cell_side<=wall_range[0] and cell_side>=wall_range[1]:
				type = 'wall'
			else:
				type = 'floor'

			cell_side_correct = bitmask_get_cell(node,x+side[0],y+side[1],type,wall_range,floor_range,debug)
			if cell_side_correct != cell_side:
				node.set_cell(x+side[0],y+side[1],cell_side_correct)
					
func place_blocks(level) -> void:
	var node
	var cell
	
	cell = 19
	node = get_node("tilemap_level_%d" % 1)
	var rm = level.start_room

	for i in range(rm.topleft.x+1,rm.botright.x):
		for j in range(rm.topleft.y+1,rm.botright.y):
			#node.set_cell(i,j,44)
			set_cell_autotile(node,i,j,44,'floor',[37,0],[44,38],0)
	for i in range(rm.topleft.x,rm.botright.x+1):
		#node.set_cell(i,rm.topleft.y,cell)
		#node.set_cell(i,rm.botright.y,cell)
		#node.set_cell(i,rm.topleft.y,bitmask_get_cell(node,i,rm.topleft.y,'wall',[37,0],[44,38]))
		#node.set_cell(i,rm.botright.y,bitmask_get_cell(node,i,rm.botright.y,'wall',[37,0],[44,38]))
		set_cell_autotile(node,i,rm.topleft.y,cell,'wall',[37,0],[44,38],0)
		set_cell_autotile(node,i,rm.botright.y,cell,'wall',[37,0],[44,38],0)
	for i in range(rm.topleft.y,rm.botright.y+1):
		#node.set_cell(rm.botright.x,i,cell)
		#node.set_cell(rm.topleft.x,i,cell)	
		set_cell_autotile(node,rm.botright.x,i,cell,'wall',[37,0],[44,38],0)
		set_cell_autotile(node,rm.topleft.x,i,cell,'wall',[37,0],[44,38],0)

	for boss_room in level.boss_rooms:

		cell = 19
		node = get_node("tilemap_level_%d" % boss_room.z)

		for i in range(boss_room.topleft.x+1,boss_room.botright.x):
			for j in range(boss_room.topleft.y+1,boss_room.botright.y):
				#node.set_cell(i,j,43)
				set_cell_autotile(node,i,j,43,'floor',[37,0],[44,38],0)

		for i in range(boss_room.topleft.x,boss_room.botright.x+1):
			#node.set_cell(i,boss_room.topleft.y,cell)
			#node.set_cell(i,boss_room.botright.y,cell)
			set_cell_autotile(node,i,boss_room.topleft.y,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,i,boss_room.botright.y,cell,'wall',[37,0],[44,38],0)
		for i in range(boss_room.topleft.y,boss_room.botright.y+1):
			#node.set_cell(boss_room.botright.x,i,cell)
			#node.set_cell(boss_room.topleft.x,i,cell)
			set_cell_autotile(node,boss_room.botright.x,i,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,boss_room.topleft.x,i,cell,'wall',[37,0],[44,38],0)
			
	for special in level.special_rooms:

		cell = 0
		node = get_node("tilemap_level_%d" % special.z)

		for i in range(special.topleft.x+1,special.botright.x):
			for j in range(special.topleft.y+1,special.botright.y):
				#node.set_cell(i,j,40)
				set_cell_autotile(node,i,j,40,'floor',[37,0],[44,38],0)

		for i in range(special.topleft.x,special.botright.x+1):
			#node.set_cell(i,special.topleft.y,cell)
			#node.set_cell(i,special.botright.y,cell)
			set_cell_autotile(node,i,special.topleft.y,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,i,special.botright.y,cell,'wall',[37,0],[44,38],0)
		for i in range(special.topleft.y,special.botright.y+1):
			#node.set_cell(special.botright.x,i,cell)
			#node.set_cell(special.topleft.x,i,cell)
			set_cell_autotile(node,special.botright.x,i,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,special.topleft.x,i,cell,'wall',[37,0],[44,38],0)
			
	for corridor in level.corridors:
		
		cell = 0
		node = get_node("tilemap_level_%d" % corridor.z)
		
		for i in range(corridor.topleft.x+1,corridor.botright.x):
			for j in range(corridor.topleft.y+1,corridor.botright.y):
				#node.set_cell(i,j,38)
				set_cell_autotile(node,i,j,38,'floor',[37,0],[44,38],0)

		for i in range(corridor.topleft.x,corridor.botright.x+1):
			#node.set_cell(i,corridor.topleft.y,cell)
			#node.set_cell(i,corridor.botright.y,cell)
			set_cell_autotile(node,i,corridor.topleft.y,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,i,corridor.botright.y,cell,'wall',[37,0],[44,38],0)
		for i in range(corridor.topleft.y,corridor.botright.y+1):
			#node.set_cell(corridor.botright.x,i,cell)
			#node.set_cell(corridor.topleft.x,i,cell)
			set_cell_autotile(node,corridor.botright.x,i,cell,'wall',[37,0],[44,38],0)
			set_cell_autotile(node,corridor.topleft.x,i,cell,'wall',[37,0],[44,38],0)
			
func create_paths_blocks(paths,floor_range,wall_range):
	var node = get_node("tilemap_level_1")
	var cell
	var yright
	var yleft
	var xright
	var xleft
	var x
	var y
	for path in paths:
		for i in range(2):  #path line count
			if path[i].x == path[i+1].x:
				xleft  = path[i].x-1
				xright = path[i].x+2
				if path[i].y<path[i+1].y:
					yleft  = path[i].y
					yright = path[i+1].y+1
				else:
					yleft  = path[i+1].y
					yright = path[i].y+1
			else:
				yleft  = path[i].y-1
				yright = path[i].y+2
				if path[i].x<path[i+1].x:
					xleft  = path[i].x
					xright = path[i+1].x+1
				else:
					xleft  = path[i+1].x
					xright = path[i].x
					
			for x in range(xleft,xright):
				for y in range(yleft,yright):
					cell = node.get_cell(x,y)
					if cell <= wall_range[0] and cell >= wall_range[1] or cell == -1:
						#node.set_cell(x,y,38)
						set_cell_autotile(node,x,y,38,'floor',[37,0],[44,38],0)
						if node.get_cell(x-1,y) == -1: set_cell_autotile(node,x-1,y,0,'wall',[37,0],[44,38],0) #node.set_cell(x-1,y,0)
						if node.get_cell(x+1,y) == -1: set_cell_autotile(node,x+1,y,0,'wall',[37,0],[44,38],0) #node.set_cell(x+1,y,0)
						if node.get_cell(x,y-1) == -1: set_cell_autotile(node,x,y-1,0,'wall',[37,0],[44,38],0) #node.set_cell(x,y-1,0)
						if node.get_cell(x,y+1) == -1: set_cell_autotile(node,x,y+1,0,'wall',[37,0],[44,38],0) #node.set_cell(x,y+1,0)
					
	
var level
var tris
var edges_data
var paths
var phys_paths

func _ready():
	randomize()
	level = create_rooms_chunk([1,1],[7,5],[7,5],6,[20,14],[20,14],0.09,[12,8],[13,8])
	#place_blocks(level)
	tris = triangulate([level.start_room]+level.boss_rooms+level.special_rooms)
	edges_data = kruskalmst([level.start_room]+level.boss_rooms+level.special_rooms,tris)
	paths = create_paths([level.start_room]+level.boss_rooms+level.special_rooms,edges_data)
	#print(paths)
	
	phys_paths = create_physical_paths(paths,[8,6],[8,6],0)
		
	level.corridors = phys_paths[0]
	level.corridors_count = phys_paths[1]
	print(level.corridors_count+level.boss_rooms_count+level.special_count)
	#spread(level.corridors,level.corridors_count)
	delete_overlaped_with_origin([level.start_room]+level.boss_rooms+level.special_rooms,phys_paths[0],phys_paths[1])
	#spread([level.start_room]+level.boss_rooms+level.special_rooms+level.corridors,1+level.boss_rooms_count+level.special_count+level.corridors_count)

	place_blocks(level)
	create_paths_blocks(paths,[44,38],[37,0])
	
#	set_cell_autotile(get_node("tilemap_level_1"),-1,0,0,'wall',[37,0],[44,38],0)
#	set_cell_autotile(get_node("tilemap_level_1"),-2,0,0,'wall',[37,0],[44,38],0)
#	set_cell_autotile(get_node("tilemap_level_1"),1,0,0,'wall',[37,0],[44,38],0)
#	set_cell_autotile(get_node("tilemap_level_1"),2,0,0,'wall',[37,0],[44,38],0)
#	set_cell_autotile(get_node("tilemap_level_1"),0,0,0,'wall',[37,0],[44,38],0)
#	set_cell_autotile(get_node("tilemap_level_1"),0,0,38,'floor',[37,0],[44,38],0)
	
	get_node("Node2D_Draw").tris = tris
	get_node("Node2D_Draw").rooms = [level.start_room]+level.boss_rooms+level.special_rooms+level.corridors
	get_node("Node2D_Draw").edges_data = edges_data
	get_node("Node2D_Draw").paths = paths
	
	get_node("Node2D_Draw").layers = 8
	get_node("Node2D_Draw").width = 20
	get_node("Node2D_Draw").space_modif_big = 6
	get_node("Node2D_Draw").space_modif_small = 2
#func _draw():
#	for room in level.boss_rooms:
#		if room.id == 3:
#			draw_circle(Vector2((room.center.x-room.center.y-(room.z-1)*64)*32,(room.center.x+room.center.y-(room.z-1)*64)*16),room.width2*16,Color(0.6,0,0))
#		if room.id == 4:
#			draw_circle(Vector2((room.center.x-room.center.y-(room.z-1)*64)*32,(room.center.x+room.center.y-(room.z-1)*64)*16),room.width2*16,Color(0.6,0.6,0))
		#draw_line(Vector2((p1.center.x-p1.center.y)*32,(p1.center.x+p1.center.y)*16),Vector2((p2.center.x-p2.center.y)*32,(p2.center.x+p2.center.y)*16),Color(0.6,0,0))
