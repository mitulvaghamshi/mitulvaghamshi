# Validate postal codes (Specific to Canada)

DEBUG_MODE = True

POSTAL_CODES_CA = [
    ["Alberta",               "AB", "$12", ["T"]],
    ["British Columbia",      "BC", "$12", ["V"]],
    ["Manitoba",              "MB", "$12", ["R"]],
    ["New Bruswick",          "NB", "$15", ["E"]],
    ["Newfoundland",          "NL", "$15", ["A"]],
    ["Northwest Territories", "NT", "$20", ["X"]],
    ["Nova Scotia",           "NS", "$15", ["B"]],
    ["Nunavut",               "NU", "$20", ["X"]],
    ["Ontario",               "ON", "$8",  ["K", "L", "M", "N", "P"]],
    ["Prince Edward Island",  "PE", "$15", ["C"]],
    ["Quebec",                "QC", "$8",  ["G", "H", "J"]],
    ["Saskatchewan",          "SK", "$12", ["S"]],
    ["Yukon",                 "YT", "$20", ["Y"]],
]

def is_postal_code_valid(self, first_letter, valid_letters):
    return (True, False)[any(first_letter == char for char in valid_letters)], valid_letters

def is_user_input_valid(self, code):
    is_space = " " in code
    return code[0].isalpha() and \
        code[1].isdigit() and \
        code[2].isalpha() and \
        code[(3, 4)[is_space]].isdigit() and \
        code[(4, 5)[is_space]].isalpha() and \
        code[(5, 6)[is_space]].isdigit()

def validate(self):
    if self.DEBUG_MODE:
        # addr_line1 = "Hamilton, Ontario"
        addr_line1 = "Hamilton, BC" # Wrong input
    else:
        addr_line1 = input("Enter your address (e.g. city, province): ")

    if not "," in addr_line1:
        print("Address must contains a ',' (e.g. Hamilton, ON)")
    else:
        province = addr_line1.split(",")[1].strip().upper()
        if self.DEBUG_MODE:
            # postal_code = "8YT 4C8"
            postal_code = "V8T4C8" # Wrong input
        else:
            postal_code = input("Enter postal code (e.g. X1X 1X1): ").upper()

        if self.is_user_input_valid(postal_code):
            address = ""
            for item in self.POSTAL_CODES_CA:
                if item[0].upper() == province or item[1] == province:
                    address = item
                    retry, valid_letters = self.is_postal_code_valid(postal_code[0], address[3])
            if retry:
                retry = False
                print("Invalid postal code! Must start with any of", valid_letters, "for", address[0], "province.")
            else:
                retry = False
                print("Shipping to", addr_line1, "-", postal_code, "it will cost", address[2])
        else:
            retry = False
            print("Invalid postal code!, Please try again\n")
