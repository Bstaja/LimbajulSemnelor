using Godot;
using System;
using System.Data.SqlClient;

public class baza_de_date_test : Node
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{/*
		String str;
 SqlConnection myConn = new SqlConnection ("Server=localhost;Integrated security=SSPI;database=Dictionar");

str = "CREATE DATABASE Dictionar ON PRIMARY " +
"(NAME = Dictionar_Data, " +
"FILENAME = 'C:\\copy drive\\Desktop\\BD\\Dictionar.mdf', " +
"SIZE = 2MB, MAXSIZE = 100MB, FILEGROWTH = 10%)" +
"LOG ON (NAME = Dictionar_Log, " +
"FILENAME = 'C:\\copy drive\\Desktop\\BD\\Dictionar.ldf', " +
"SIZE = 1MB, " +
"MAXSIZE = 50MB, " +
"FILEGROWTH = 10%)" +*/

/*str= "CREATE TABLE Categorii(" +
"NumeCategorie varchar(50)," +
"Folder varchar(50)," +
"Locatie varchar(50)"+
")";

str="INSERT INTO Categorii VALUES ('Animale', 'test', 'test1')";
str="INSERT INTO Categorii VALUES ('Flori', 'test', 'test12')";
str="INSERT INTO Categorii VALUES ('Carti', 'test', 'test13')";
str="INSERT INTO Categorii VALUES ('Melodii', 'test', 'test15')";



 






SqlCommand myCommand = new SqlCommand(str, myConn);
try
{
	myConn.Open();
	myCommand.ExecuteNonQuery();
	GD.Print("DataBase is Created Successfully");

}
catch (System.Exception ex)
{
	GD.Print(ex.ToString());

}
finally
{
	
}
*/
	
		
string queryString = "SELECT TOP (1000) [NumeCategorie],[Folder],[Locatie] FROM [Dictionar].[dbo].[Categorii]";
string connectionString = "Server=localhost;Integrated security=SSPI;database=Dictionar";

using (SqlConnection connection = new SqlConnection(connectionString))
{
	SqlCommand command = new SqlCommand(queryString, connection);
	connection.Open();
	SqlDataReader reader = command.ExecuteReader();
	try
	{
		while (reader.Read())
		{
			GD.Print(String.Format("{0}, {1}",
			reader["NumeCategorie"], reader["Locatie"]));
		}
	}
	finally
	{
		// Always call Close when done reading.
		reader.Close();
	}
}

	}


}
