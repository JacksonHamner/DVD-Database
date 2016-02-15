//Programmers: Powell Hamner and Kerry Finnan
//Assignment:  Team Project 2
//Class:       CIS 284
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    public GridViewRow row;
    protected void Page_Load(object sender, EventArgs e){ }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (grdDVD.DataSourceID == SqlDataSource1.ID)
        {
            grdDVD.DataSourceID = SqlDataSource3.ID;
            btnSearch.Text = "Cancel Search";
            lblSearch.Visible = false;
            txtSearch.Visible = false;

        }
        else if (grdDVD.DataSourceID == SqlDataSource3.ID)
        {
            grdDVD.DataSourceID = SqlDataSource1.ID;
            btnSearch.Text = "Search";
            lblSearch.Visible = true;
            lblError.Visible = false;
            txtSearch.Visible = true;
            txtSearch.Text = "";
            grdDVD.Visible = true;
            DetailsView1.Visible = true;
        }
    }

    protected void DetailsView1_ItemUpdated(
    object sender, DetailsViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = "A database error has occurred.<br /><br />" +
                "Message: " + e.Exception.Message;
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else if (e.AffectedRows == 0)
            lblError.Text = "Another user may have updated that customer."
                + "<br />Please try again.";
        else
            grdDVD.DataBind();
    }

    protected void DetailsView1_ItemDeleted(
        object sender, DetailsViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = "A database error has occurred.<br /><br />" +
                "Message: " + e.Exception.Message;
            e.ExceptionHandled = true;
        }
        else if (e.AffectedRows == 0)
            lblError.Text = "Another user may have updated that customer."
                + "<br />Please try again.";
        else
            grdDVD.DataBind();
    }

    protected void DetailsView1_ItemInserted(
        object sender, DetailsViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            lblError.Text = "A database error has occurred.<br /><br />" +
                "Message: " + e.Exception.Message;
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
        }
        else
            grdDVD.DataBind();
    }
}