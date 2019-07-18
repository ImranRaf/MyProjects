# Battleships

# Global imports & variables
import random
# Constants for the max grid reference
X_SIZE = 6
Y_SIZE = 6

# Create the grid using a class funtion
class Grid(object):
	def __init__(self, columns, rows):
		self.columns = columns
		self.rows = rows
		self.grid = []
		# Loop through the list for rows and repeat through columns
		for _ in range(rows):
			row = []
			for _ in range(columns):
				row.append('0')
			# Add the created 2D array back to 'self.grid'
			self.grid.append(row)

	# Definition to display the grid and supplies the column and row indexes (A,1 to L,12)
	def display(self):
		column_names = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[:self.columns]
		# Print the column names with a line between for user reference
		print('  | ' + ' | '.join(column_names) + ' | ')
		# Loop through the created 2D array and fill with 'O' as default
		for number, row in enumerate(self.grid, 1):
			print(number, ' | ' + ' | '.join(row) + ' | ')
	
	# Def is created to stored the inputed x and y co-ords from the user for loop iterates
	# Through first y & x co-ords setting stored data from the user input to the grid &
	# ship.id is allocated to the position using the data passed from the list
	def addShip(self,ship):
		for y in range(ship.ystart,ship.yend+1):
			for x in range(ship.xstart, ship.xend+1):
				self.grid[y][x] = ship.id

# Class for the object ship to be stored into the grid array
# Co-ord position data is initialised to -1 for default on start-up
class Ship(object):
	def __init__(self,id,size):
		self.id = str(id)
		self.size = size
		self.xstart = -1
		self.ystart = -1
		self.xend = -1
		self.yend = -1

	# Def was created to store the initialised variables for the ships position on the grid
	def shipPos(self,xstart,ystart,xend,yend):
		self.xstart, self.ystart, self.xend, self.yend = xstart, ystart, xend, yend

# Object class for the human player to store attributes and ship references
class Player(object):
	def __init__(self,name,pl_grid,op_grid):
		self.name = name
		self.pl_grid = pl_grid
		self.op_grid = op_grid
		self.ships = []

	# appends the ships on the board for the player
	def addShip(self, ship):
		self.pl_grid.addShip(ship)
		self.ships.append(ship)

# Object class for the AI player, inherts from Player class
class AIplayer(Player):
	def __init__(self,name,pl_grid,op_grid):
		super().__init__(name,pl_grid,op_grid)

	# Created to handle the AI ships as objects to the class to handle hits and misses
	def AIaddships(self,ai_ships):
		# used to set an integer value for the AI while loop. 0 to start from the first instance of
		# The count value of 'ships'
		ship_num = 0

		# AI adding ships to the board is created by using a while loop to help in further checks
		# The previous value 'ship_num' let's us iterate through the loop until the max count of
		# the 'ships' list is reached, allowing all ships to be iterated through
		while (ship_num < len(ai_ships)):
			xstart = random.randint(0,X_SIZE-1)
			ystart = random.randint(0,Y_SIZE-1)
			angle = random.randint(0,1)		# 0 for horizontal, 1 for vertical
			if angle == 0:
				# Horizontal value has been selected so the x value needs to be in-line with the
				# Size of the ship, matching the id. This is done by equal-ing the end value to the
				# Start value and adding the ships size. -1 is calculated at the end as a value of
				# Size 2 would equate to 3 spaces as the 0 is counted also as a value.
				xend = xstart + ai_ships[ship_num].size-1
				yend = ystart
				# This condition is to prevent the AI from placing pieces off the board, if the end
				# Value is equal to a value over 11 the end value is set to the start value and the
				# Start value is set to itself - the ship size + 1
				if xend >= 5:
					xend,xstart = xstart,(xstart - ai_ships[ship_num].size+1)
				# This for loop checks the range between the start and end value, if the values of that
				# range don't equal the ship id then break the for loop and try again.
				for x in range(xstart,xend):
					if ship_num != ship.id:
						xstart = xstart - 1
						xend = xend - 1
			# This is a repeat of the above just with the y values that represent the vertical pieces	
			elif angle == 1:
				xend = xstart
				yend = ystart + ai_ships[ship_num].size-1
				if yend >= 5:
					yend,ystart = ystart,(ystart - ai_ships[ship_num].size+1)
				for y in range(ystart,yend):
					if ship_num != ship.id:
						ystart = ystart - 1
						yend = yend - 1
			# A check that prints the co-ords for the x and y values and the ship size for reference.
			# The random inputs stored are then linked back to the 'shipPos' def as int values
			# The ship is then stored to the AI grid using the 'addShip' def by the loop's iteration
			#print(xstart,ystart,xend,yend,"size",ships[ship_num].size) // testing purposes
			ai_ships[ship_num].shipPos(int(xstart),int(ystart),int(xend),int(yend))
			self.ships.append(ai_ships[ship_num])
			self.pl_grid.addShip(ai_ships[ship_num])
			# Adds 1 to the loop to allow for an exit from the loop to avoid an endless loop.
			ship_num += 1

# Initialising the grid
grid = Grid(X_SIZE,Y_SIZE)	# Grid size for player can be changed here
ai_grid = Grid(X_SIZE,Y_SIZE)	# Grid size for the AI

# List of ships used for referencing through selectable positions
p1_ships = [Ship(1,2),Ship(2,2),Ship(3,3),Ship(4,3)]#,Ship(5,3),Ship(6,4),Ship(7,5)]
ai_ships = [Ship(1,2),Ship(2,2),Ship(3,3),Ship(4,3)]

# Welcome messages to the user for reference at the start of the game
print("Welcome to Battleship!")
print("Ships to place are as follows: \n" , "1+2.Patrolboat \n3+4.Battleship \n")# \n5.Submarine x1 \n6.Destroyer x1 \n7.Aircraft carrier x1\n")

# Initialising the grids for both player and AI
p1 = Player("Player 1", Grid(X_SIZE,Y_SIZE), Grid(X_SIZE,Y_SIZE))
AI = AIplayer("AI player", Grid(X_SIZE,Y_SIZE), Grid(X_SIZE,Y_SIZE))

# This for loop asks the user for a start and end position using input
# Using the split func to take x and y co-ord, referencing the ships through the 'ships' list
# the inputs are converted to int values and called to the 'addShip' def func
for ship in p1_ships:
	print("This is ship "+ship.id+" and it has "+str(ship.size)+" spaces")
	xstart,ystart = input("Where do you want ship "+ship.id+" to start? ").split(",")
	xend,yend = input("Where do you want ship "+ship.id+" to finish? ").split(",")
	ship.shipPos(int(xstart),int(ystart),int(xend),int(yend))
	p1.addShip(ship)

AI.AIaddships(ai_ships)


# Display the updated grid to the interface
print("\nPlayer board")
p1.pl_grid.display()
print("\nAI board")
AI.pl_grid.display()

# Gameplay for firing
# TO DO!
'''while True:
	try:
		guess_row = int(input("Choose the x co-ords to fire at: "))
		guess_col = int(input("Choose the y co-ords to fire at: "))
		if (guess_row == ship.id and guess_col == ship.id):
			pass
	except:
		print("Invalid number, try again.")'''