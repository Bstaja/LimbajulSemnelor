using Godot;
using System;
using System.Data.SqlClient;

public class AudagatorDeCuvinte:  Node
{
    GDScript ObtinatorCuvinte = GD.Load<GDScript>("res://ToateCuvintele.gd");
    string str;
    public override void _Ready()
    {
        Godot.Collections.Array test = (Godot.Collections.Array)ObtinatorCuvinte.Call("cuvinte");
        SqlConnection myConn2 = new SqlConnection ("Server=localhost;Integrated security=SSPI;database=Dictionar");
        str = "DELETE FROM Categorii";
        SqlCommand myCommand2 = new SqlCommand(str, myConn2);
        try
        {
            myConn2.Open();
            myCommand2.ExecuteNonQuery();
            Console.WriteLine(str);

        }
        catch (System.Exception ex)
        {
            GD.Print(ex.ToString());

        }
        finally
        {
            
        }
        myConn2.Close();

        foreach(Godot.Collections.Array i in test)
        {
            str="INSERT INTO Categorii VALUES ('"+i[0]+"', '"+i[1]+"', '"+i[2]+"', '"+i[3]+"')";
            SqlConnection myConn = new SqlConnection ("Server=localhost;Integrated security=SSPI;database=Dictionar");
            SqlCommand myCommand = new SqlCommand(str, myConn);
            try
            {
                myConn.Open();
                myCommand.ExecuteNonQuery();
                Console.WriteLine(str);

            }
            catch (System.Exception ex)
            {
                GD.Print(ex.ToString());

            }
            finally
            {
                
            }
            myConn.Close();
        }
    }
        
        
    


}
