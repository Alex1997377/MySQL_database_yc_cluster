class Value_SQL:
    def create_table(self):
        self.name = str(input("Ввидите название таблицы: "))
        try:
            self.tables = int(input("Выберите кол-во столбцов включая - id: "))
        except ValueError:
            self.tables = int(input("Введите целое число... "))
        self.request = ""
        for _ in range(self.tables):
            self.table = str(input("Введите название столбца: "))
            self.request += self.table
            self.request += " "
            self.type = (str(input("Введите тип и особенности столбца: "))).upper()
            self.request += self.type
            self.request += ", "
        return f"CREATE TABLE {self.name}({self.request[:-2]})"
    
    
