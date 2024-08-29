### 1. **Set Up the MySQL Database**

   1. **Install MySQL**: If you don't have MySQL installed, download and install it from [MySQL's official website](https://dev.mysql.com/downloads/mysql/).
   
   2. **Create the Database**:
      - Open a terminal or command prompt.
      - Start the MySQL command line by typing `mysql -u root -p` and enter your MySQL root password.
      - Navigate to the `sql` folder of the cloned project.
      - Run the SQL script files in the following order to create and populate the database:

        ```sql
        source path/to/your/cloned/repo/Project_Databases/sql/create_tables.sql;
        source path/to/your/cloned/repo/Project_Databases/sql/insert_data.sql;
        ```

      - These commands will create the necessary tables and insert initial data into the database.

### 2. **Set Up the Java Project in NetBeans**

   1. **Install NetBeans**: If you don't have it, download and install [NetBeans](https://netbeans.apache.org/).
   
   2. **Clone the Repository**:
      - Clone the repository to your local machine using the command:
      
        ```bash
        git clone https://github.com/paflou/Project_Databases.git
        ```
   
   3. **Import the Project into NetBeans**:
      - Open NetBeans.
      - Go to `File` > `Open Project`.
      - Navigate to the cloned repository directory and select the `Project_Databases` folder. NetBeans will recognize it as a Java project.

   4. **Configure MySQL Connection**:
      - In the `src` directory of the NetBeans project, find the file where the database connection is established (likely a `config` or `database` file).
      - Update the MySQL connection string, username, and password according to your local MySQL setup. It should look something like this:
      
        ```java
        String url = "jdbc:mysql://localhost:3306/your_database_name";
        String user = "your_mysql_username";
        String password = "your_mysql_password";
        ```
        
   5. **Build and Run the Project**:
      - Right-click on the project in the NetBeans `Projects` tab.
      - Select `Build` to compile the project.
      - Once the build is successful, right-click the project again and select `Run`. This will execute the application.
