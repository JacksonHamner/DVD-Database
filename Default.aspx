<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<%--
    Programmers: Powell Hamner and Kerry Finnan
    Assignment:  Team Project 2
    Class:       CIS 284 
--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DVD Search</title>
    <link href="css/Main.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <header><img alt="DVDBanner" class="auto-style1" src="Images/dvdBanner.png" /></header>
    <section>
        <form id="form1" runat="server">
            <%-- Search Controls --%>
            <div id="controls">
                <asp:Label ID="lblSearch" runat="server" ForeColor="White" Text="Find DVD by Title:"></asp:Label>
                <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="Button1_Click" />
            </div>
            <%-- The GridView Control--%>
            <div id="gridview">
                <asp:GridView ID="grdDVD" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="DvdID"
                    DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333"
                    GridLines="None" BorderColor="White" BorderStyle="Solid"
                    BorderWidth="5px" Width="662px" PageSize="20" SelectedIndex="0">
                    <EmptyDataRowStyle BackColor="LightBlue"
                        ForeColor="Red" />
                    <%-- If no rows returned, this will display a message and image alerting
                        the user --%>
                    <EmptyDataTemplate>
                        <asp:Image ID="NoDataImage"
                            ImageUrl="~/Images/transparent-red-no-circle-th.png"
                            AlternateText="No Image"
                            runat="server" />
                        No Data Found.  
                    </EmptyDataTemplate>

                    <AlternatingRowStyle BackColor="#CCCCFF" />

                    <Columns>
                        <asp:BoundField DataField="DvdID" HeaderText="DvdID" SortExpression="DvdID" ReadOnly="True" Visible="False"></asp:BoundField>
                        <asp:BoundField DataField="DVD_Title" HeaderText="Title" SortExpression="DVD_Title"></asp:BoundField>
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}"></asp:BoundField>
                        <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year"></asp:BoundField>
                        <asp:BoundField DataField="DVD_ReleaseDate" DataFormatString="{0:d}" HeaderText="Release Date" SortExpression="DVD_ReleaseDate" />
                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <%--Original Color: #00CC00 Feel free to change it back if you dont like the new one --%>
                    <SelectedRowStyle BackColor="#75CD75" ForeColor="White" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle BackColor="#1C5E55" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                </asp:GridView>
                <%-- Data Sources 1 and 3 (Main DataSource, and search DataSource--%>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [DvdID], [DVD_Title], [Price], [Year], [DVD_ReleaseDate] FROM [tblDvdList] ORDER BY [DVD_Title]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [DvdID], [DVD_Title], [Price], [Year], [DVD_ReleaseDate] FROM [tblDvdList] WHERE ([DVD_Title] LIKE '%' + @DVD_Title + '%')" >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="DVD_Title" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <%-- End GridView, Begin DetailsView --%>
            <h1 id="h1AddInfo">
                <label>Additional DVD Information</label></h1>
            <div id="detailsview">
                <asp:DetailsView ID="DetailsView1" runat="server"
                    AutoGenerateRows="False" DataKeyNames="DvdID"
                    DataSourceID="SqlDataSource2" Height="50px" Width="500px"
                    GridLines="None" AlternatingRowStyle-BackColor="#E3EAEB"
                    OnItemDeleted="DetailsView1_ItemDeleted"
                    OnItemInserted="DetailsView1_ItemInserted"
                    OnItemUpdated="DetailsView1_ItemUpdated" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" CellPadding="2" BackColor="#009999">
                    <AlternatingRowStyle BackColor="#009999"></AlternatingRowStyle>
                    <Fields>
                        <asp:TemplateField HeaderText="DVD Title:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" HeaderStyle-Width="125px">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("DVD_Title") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="txtTitle" ErrorMessage="Dvd Title is a required field." CssClass="error">*
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("DVD_Title") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ControlToValidate="txtTitle" ErrorMessage="Dvd Title is a required field." CssClass="error">*
                                </asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("DVD_Title") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Studio:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStudio" runat="server" Text='<%# Bind("Studio") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtStudio" runat="server" Text='<%# Bind("Studio") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStudio" runat="server" Text='<%# Bind("Studio") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sound:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtSound" runat="server" Text='<%# Bind("Sound") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtSound" runat="server" Text='<%# Bind("Sound") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSound" runat="server" Text='<%# Bind("Sound") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Versions:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtVersion" runat="server" Text='<%# Bind("Versions") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtVersion" runat="server" Text='<%# Bind("Versions") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblVersion" runat="server" Text='<%# Bind("Versions") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Price must be a number greater than 0." CssClass="error" ControlToValidate="txtPrice" Display="Static" Type="Currency" Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>'></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Price must be a number greater than 0." CssClass="error" ControlToValidate="txtPrice" Display="Static" Type="Currency" Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rating:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRating" runat="server" Text='<%# Bind("Rating") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtRating" runat="server" Text='<%# Bind("Rating") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblRating" runat="server" Text='<%# Bind("Rating") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Year:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtYear" runat="server" Text='<%# Bind("Year") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtYear" runat="server" Text='<%# Bind("Year") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblYear" runat="server" Text='<%# Bind("Year") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release Date:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtReleaseDate" runat="server" Text='<%# Bind("DVD_ReleaseDate") %>' TextMode="Date"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="DVD release date must be in Date format." CssClass="error" ControlToValidate="txtReleaseDate" Display="Static" Type="Date" Operator="DataTypeCheck">*</asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtReleaseDate" runat="server" Text='<%# Bind("DVD_ReleaseDate") %>' TextMode="Date"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator4" runat="server" CssClass="error" ControlToValidate="txtReleaseDate" Display="Static" Type="Date" Operator="DataTypeCheck" ErrorMessage="DVD release date must be in Date format.">*</asp:CompareValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblReleaseDate" runat="server" Text='<%# Bind("DVD_ReleaseDate", "{0:d}") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Genre:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtGenre" runat="server" Text='<%# Bind("Genre") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtGenre" runat="server" Text='<%# Bind("Genre") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblGenre" runat="server" Text='<%# Bind("Genre") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Aspect:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAspect" runat="server" Text='<%# Bind("Aspect") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtAspect" runat="server" Text='<%# Bind("Aspect") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAspect" runat="server" Text='<%# Bind("Aspect") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UPC:" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUPC" runat="server" Text='<%# Bind("UPC") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="txtUPC" runat="server" Text='<%# Bind("UPC") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblUPC" runat="server" Text='<%# Bind("UPC") %>' Font-Bold="True"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" ItemStyle-BackColor="#1C5E55">
                            <ItemStyle BackColor="#1C5E55"></ItemStyle>
                        </asp:CommandField>
                    </Fields>
                </asp:DetailsView>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" HeaderText="Please correct the following errors" />
                <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                    ConflictDetection="CompareAllValues"
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    OldValuesParameterFormatString="original_{0}"
                    SelectCommand="SELECT * FROM [tblDvdList] WHERE ([DvdID] = @DvdID)"
                    DeleteCommand="DELETE FROM [tblDvdList] WHERE [DvdID] = @original_DvdID AND (([DVD_Title] = @original_DVD_Title) OR ([DVD_Title] IS NULL AND @original_DVD_Title IS NULL)) AND (([Studio] = @original_Studio) OR ([Studio] IS NULL AND @original_Studio IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL)) AND (([Sound] = @original_Sound) OR ([Sound] IS NULL AND @original_Sound IS NULL)) AND (([Versions] = @original_Versions) OR ([Versions] IS NULL AND @original_Versions IS NULL)) AND (([Price] = @original_Price) OR ([Price] IS NULL AND @original_Price IS NULL)) AND (([Rating] = @original_Rating) OR ([Rating] IS NULL AND @original_Rating IS NULL)) AND (([Year] = @original_Year) OR ([Year] IS NULL AND @original_Year IS NULL)) AND (([Genre] = @original_Genre) OR ([Genre] IS NULL AND @original_Genre IS NULL)) AND (([Aspect] = @original_Aspect) OR ([Aspect] IS NULL AND @original_Aspect IS NULL)) AND (([UPC] = @original_UPC) OR ([UPC] IS NULL AND @original_UPC IS NULL)) AND (([DVD_ReleaseDate] = @original_DVD_ReleaseDate) OR ([DVD_ReleaseDate] IS NULL AND @original_DVD_ReleaseDate IS NULL))"
                    InsertCommand="INSERT INTO tblDvdList(DVD_Title, Studio, Status, Sound, Versions, Price, Rating, Year, Genre, Aspect, UPC, DVD_ReleaseDate) VALUES (@DVD_Title, @Studio, @Status, @Sound, @Versions, @Price, @Rating, @Year, @Genre, @Aspect, @UPC, @DVD_ReleaseDate)"
                    UpdateCommand="UPDATE [tblDvdList] SET [DVD_Title] = @DVD_Title, [Studio] = @Studio, [Status] = @Status, [Sound] = @Sound, [Versions] = @Versions, [Price] = @Price, [Rating] = @Rating, [Year] = @Year, [Genre] = @Genre, [Aspect] = @Aspect, [UPC] = @UPC, [DVD_ReleaseDate] = @DVD_ReleaseDate WHERE [DvdID] = @original_DvdID AND (([DVD_Title] = @original_DVD_Title) OR ([DVD_Title] IS NULL AND @original_DVD_Title IS NULL)) AND (([Studio] = @original_Studio) OR ([Studio] IS NULL AND @original_Studio IS NULL)) AND (([Status] = @original_Status) OR ([Status] IS NULL AND @original_Status IS NULL)) AND (([Sound] = @original_Sound) OR ([Sound] IS NULL AND @original_Sound IS NULL)) AND (([Versions] = @original_Versions) OR ([Versions] IS NULL AND @original_Versions IS NULL)) AND (([Price] = @original_Price) OR ([Price] IS NULL AND @original_Price IS NULL)) AND (([Rating] = @original_Rating) OR ([Rating] IS NULL AND @original_Rating IS NULL)) AND (([Year] = @original_Year) OR ([Year] IS NULL AND @original_Year IS NULL)) AND (([Genre] = @original_Genre) OR ([Genre] IS NULL AND @original_Genre IS NULL)) AND (([Aspect] = @original_Aspect) OR ([Aspect] IS NULL AND @original_Aspect IS NULL)) AND (([UPC] = @original_UPC) OR ([UPC] IS NULL AND @original_UPC IS NULL)) AND (([DVD_ReleaseDate] = @original_DVD_ReleaseDate) OR ([DVD_ReleaseDate] IS NULL AND @original_DVD_ReleaseDate IS NULL))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="grdDVD" Name="DvdID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="original_DvdID" Type="Int32" />
                        <asp:Parameter Name="original_DVD_Title" Type="String" />
                        <asp:Parameter Name="original_Studio" Type="String" />
                        <asp:Parameter Name="original_Status" Type="String" />
                        <asp:Parameter Name="original_Sound" Type="String" />
                        <asp:Parameter Name="original_Versions" Type="String" />
                        <asp:Parameter Name="original_Price" Type="Decimal" />
                        <asp:Parameter Name="original_Rating" Type="String" />
                        <asp:Parameter Name="original_Year" Type="String" />
                        <asp:Parameter Name="original_Genre" Type="String" />
                        <asp:Parameter Name="original_Aspect" Type="String" />
                        <asp:Parameter Name="original_UPC" Type="String" />
                        <asp:Parameter Name="original_DVD_ReleaseDate" Type="DateTime" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="DVD_Title" Type="String" />
                        <asp:Parameter Name="Studio" Type="String" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="Sound" Type="String" />
                        <asp:Parameter Name="Versions" Type="String" />
                        <asp:Parameter Name="Price" Type="Decimal" />
                        <asp:Parameter Name="Rating" Type="String" />
                        <asp:Parameter Name="Year" Type="String" />
                        <asp:Parameter Name="Genre" Type="String" />
                        <asp:Parameter Name="Aspect" Type="String" />
                        <asp:Parameter Name="UPC" Type="String" />
                        <asp:Parameter Name="DVD_ReleaseDate" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DVD_Title" Type="String" />
                        <asp:Parameter Name="Studio" Type="String" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="Sound" Type="String" />
                        <asp:Parameter Name="Versions" Type="String" />
                        <asp:Parameter Name="Price" Type="Decimal" />
                        <asp:Parameter Name="Rating" Type="String" />
                        <asp:Parameter Name="Year" Type="String" />
                        <asp:Parameter Name="Genre" Type="String" />
                        <asp:Parameter Name="Aspect" Type="String" />
                        <asp:Parameter Name="UPC" Type="String" />
                        <asp:Parameter Name="DVD_ReleaseDate" Type="DateTime" />
                        <asp:Parameter Name="original_DvdID" Type="Int32" />
                        <asp:Parameter Name="original_DVD_Title" Type="String" />
                        <asp:Parameter Name="original_Studio" Type="String" />
                        <asp:Parameter Name="original_Status" Type="String" />
                        <asp:Parameter Name="original_Sound" Type="String" />
                        <asp:Parameter Name="original_Versions" Type="String" />
                        <asp:Parameter Name="original_Price" Type="Decimal" />
                        <asp:Parameter Name="original_Rating" Type="String" />
                        <asp:Parameter Name="original_Year" Type="String" />
                        <asp:Parameter Name="original_Genre" Type="String" />
                        <asp:Parameter Name="original_Aspect" Type="String" />
                        <asp:Parameter Name="original_UPC" Type="String" />
                        <asp:Parameter Name="original_DVD_ReleaseDate" Type="DateTime" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </form>
    </section>
</body>
</html>
