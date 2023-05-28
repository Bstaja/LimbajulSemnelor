using Godot;
using System;
using System.Data.SqlClient;

public class baza_de_date_test : Node
{
	public override void _Ready()
	{
		String str;
		SqlConnection myConn = new SqlConnection ("Server=localhost;Integrated security=SSPI;database=Dictionar");

		str= "CREATE TABLE Categorii(" +
		"Categorie varchar(50) NOT NULL," +
		"Folder varchar(50) NOT NULL," +
		"Locatie varchar(50) NOT NULL,"+
		"Cuvant varchar(50) NOT NULL,"+
		"PRIMARY KEY (Categorie, Cuvant)" +
		")";


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

	}


}
