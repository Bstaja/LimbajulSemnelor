using Godot;
using System;
using System.Data.SqlClient;

public class AccesBazaDate : Node
{
    public string DinCategorie(string categorie)
    {
        string rezultat = "";
        string queryString = "SELECT * FROM Categorii WHERE Categorie = " + "'" + categorie + "'";
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
                    rezultat += String.Format("{0}, {1}, {2}, {3}",
                    reader["Categorie"], reader["Folder"], reader["Locatie"], reader["Cuvant"]) + "\n";
                }
            }
            catch(System.Exception ex)
		    {
			    GD.Print(ex.ToString());
            }
            finally
            {
                // Always call Close when done reading.
                reader.Close();
            }
        }

        return rezultat;
    }
}
