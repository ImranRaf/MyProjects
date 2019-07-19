from pymongo import MongoClient

host = "localhost"
port = 27017
client = MongoClient(host, port)
mydb = client["Tesgo"]
stock_collection = mydb["Stock"]
staff_collection = mydb["Staff"]


class Stock(object):
	def __init__ (self,name,cost,quantity):
		self.name = name
		self.cost = cost
		self.quantity = quantity

	def readall(self):
		# displays all items to the screen
		stock_data = stock_collection.find()
		for document in stock_data:
			print (document)

	def search(self):
		# find the document containing the details for a specific item
		myquery = {"name":input("What item are you looking for: ")}
		doc = stock_collection.find_one(myquery)
		# none is returned if the item is not found
		if doc is not None:
			print(doc)
		else:
			print("Item not found: ", myquery)

	def additem(self):
		# insert a list a item into the stock
		while(True):
			A = input("Would you like to add an item to the stock? Y/N: ")
			if (A == "Y"):
				new_items = [
					{"name": input("Please enter the name of the product to be added: "), "cost": float(input("Please enter the cost of the product to be added: ")),"quantity": int(input("Please enter the quantity of this item: "))},
				]
				new_ids = stock_collection.insert_many(new_items)
			elif (A == "N"):
				break
			else:
				print("invalid response. Please try again")

		print("Inserted IDs and stock names")
		for id in new_ids.inserted_ids:
			print(id)

	def damages(self):
		# change the quantity of an item if the item is damaged
		while(True):
			A = input("Has an item been damaged? Y/N: ")
			if (A == "Y"):		
				user_item_input = input("What is the name of the item damaged: ")
				myquery = {"name": user_item_input}
				B = int(input("how many of this item has been damaged: "))
				# find and checks the stock amount of the item entered
				current_stock = stock_collection.find_one({"name": user_item_input})["quantity"]
				newvalues = {"$set":{"quantity": current_stock-B}}
				# prints a count of items amended
				result = stock_collection.update_one(myquery, newvalues)
				print("%d items matched, %d items updated"
					%(result.matched_count, result.modified_count))
			elif (A == "N"):
				break
			else:
				print("oops, wrong answer. Please try again.")

	def saleitems(self):
		# change the quantity of an item if the item is damaged
		while(True):
			A = input("Do you wish to add items to sale? Y/N: ")
			if (A == "Y"):		
				user_item_input = input("What is the name of the item on sale: ")
				myquery = {"name": user_item_input}
				B = float(input("What is the new price: "))
				newvalues = {"$set":{"cost": B}}
			elif (A == "N"):
				break
			else:
				print("oops, wrong answer. Please try again.")
		result = stock_collection.update_one(myquery, newvalues)
		print("%d items matched, %d items updated"
			%(result.matched_count, result.modified_count))

	def removeitem(self):
		# delete one item
		item = {"name": input("Enter the item you wish to remove: ")}
		results = stock_collection.delete_many(item)
		print("\nDeleted %d items" %(results.deleted_count))


class Staff(object):

	def __init__(self,fname,surname,role,salary):
		self.fname = fname
		self.surname = surname
		self.role = role
		self.salary = salary


	def addstaff(self):
		# insert an employee into the collection
		while(True):
			A = input("Would you like to add an employee? Y/N: ")
			if (A == "Y"):
				new_items = [
					{"fname": input("Please enter their first name: "), "surname": input("Please enter their surname: "),"role": input("What is this employees role: "), "salary": int(input("Enter the employees salary: "))},
				]
				new_ids = staff_collection.insert_many(new_items)
			if (A == "N"):
				break
			else:
				print("invalid response. Please try again")

		print("Inserted IDs and employee names")
		for id in new_ids.inserted_ids:
			print(id)

	def deletestaff(self):
		# deletes the member of staff matching the first and last name
		item = {"fname": input("Enter the employees first name: "), "surname": input("Enter the surname: ")}
		results = staff_collection.delete_one(item)
		print("\nDeleted %d staff members" %(results.deleted_count))

	def updatesurname(self):
		# to update staff records already on system
		while(True):
			A = input("Do you wish to update your details? Y/N: ")
			if (A == "Y"):		
				user_input = input("What is was your surname: ")
				myquery = {"surname": user_input}
				B = input("What is your new surname: ")
				newvalues = {"$set":{"surname": B}}
			elif (A == "N"):
				break
			else:
				print("oops, wrong answer. Please try again.")
		result = stock_collection.update_one(myquery, newvalues)
		print("%d items matched, %d staff updated"
			%(result.matched_count, result.modified_count))

	def allstaff(self):
		# displays all staff to the screen
		staff_data = staff_collection.find()
		for document in staff_data:
			print (document)

	def staffpromotions(self):
		# to update staff records already on system
		while(True):
			A = input("Do you wish to update staff details? Y/N: ")
			if (A == "Y"):		
				user_input = input("What is their surname surname: ")
				myquery = {"surname": user_input}
				B = input("What is the new position: ")
				newvalues = {"$set":{"role": B}}
			elif (A == "N"):
				break
			else:
				print("oops, wrong answer. Please try again.")
		result = stock_collection.update_one(myquery, newvalues)
		print("%d items matched, %d staff updated"
			%(result.matched_count, result.modified_count))

	def salaryupdates(self):
		# to update staff records already on system
		while(True):
			A = input("Do you wish to update staff payroll? Y/N: ")
			if (A == "Y"):		
				user_input = input("What is their surname surname: ")
				myquery = {"surname": user_input}
				B = int(input("What is the new salary: "))
				newvalues = {"$set":{"salary": B}}
			elif (A == "N"):
				break
			else:
				print("oops, wrong answer. Please try again.")
		result = stock_collection.update_one(myquery, newvalues)
		print("%d items matched, %d staff updated"
			%(result.matched_count, result.modified_count))

# While loop running the UI system to the CMD
# Stock and Staff have been added, verification still needs to be added using a list of passwords 
# linked to a staff role
print("Welcome to Tesgo!")
while(True):
	enter = input("Do you wish to have access? Y/N: ")
	if (enter == "Y" or enter == "y"):
		user_option = int(input("Do you wish to access: 1. Staff or 2. Stock? "))
		if (user_option == 1):
			print("Please choose from the following options:")
			print("1. Add staff members\n","2. Delete staff members\n","3. Update marriage certificate\n","4. View all staff members\n","5. Staff promotions\n","6. Update payroll\n")
			user_option2 = int(input("Please select an option: "))
			if (user_option2 == 1):
				# insert an employee into the collection
				Staff.addstaff(Staff)
			if (user_option2 == 2):
				# deletes the member of staff matching the first and last name
				Staff.deletestaff(Staff)
			if (user_option2 == 3):
				# to update staff records already on system
				Staff.updatesurname(Staff)
			if (user_option2 == 4):
				# displays all staff to the screen
				Staff.allstaff(Staff)
			if (user_option2 == 5):
				# to update staff records already on system
				Staff.staffpromotions(Staff)
			if (user_option2 == 6):
				# to update staff records already on system
				Staff.salaryupdates(Staff)
		elif (user_option == 2):
			print("Please choose from the following options:")
			print("1. Read all available stock\n","2. Search for 1 item\n","3. Add an item to the stock\n","4. update broken stock\n","5. Move item to sale\n","6. Remove an item from stock\n")
			startvalue = int(input("Enter the number next to the option you wish to proceed with: "))
			if(startvalue == 1):
				# displays all items to the screen
				Stock.readall(Stock)
			elif(startvalue == 2):
				# find the document containing the details for a specific item
				Stock.search(Stock)
			elif(startvalue == 3):
				# insert a list a item into the stock
				Stock.additem(Stock)
			elif(startvalue == 4):
				# change the quantity of an item if the item is damaged
				Stock.damages(Stock)
			elif (startvalue == 5):
				# change the quantity of an item if the item is damaged
				Stock.saleitems(Stock)
			elif (startvalue == 6):
				# delete one item
				Stock.removeitem(Stock)
			elif(startvalue < 1 or startvalue > 7):
				break
		elif(user_option > 2 or user_option < 1):
			break
	elif(enter == "N" or enter == "n"):
		print("Thanks for using Tesgo")
		break
	else:
		print("Not a valid response, try again.")

# end client session  ... cleanup client resources and disconnect from MongoDB
client.close()