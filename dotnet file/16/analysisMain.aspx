<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="AnalysisMain.aspx.cs" Inherits="AnalysisMain" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>

<%@ Register Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxEditors" Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxClasses" Assembly="DevExpress.Web.v12.2, Version=12.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	
    <script type="text/javascript">
        var CheckedId1 = [];
        var selectedRecordCount;
        function gvAnalyses_SelectionChanged(s, e) {
            s.GetSelectedFieldValues("AnalysisId", GetSelectedFieldValuesCallback1);
        }
        function GetSelectedFieldValuesCallback1(values) {
            try {
                for (var i = 0; i < values.length; i++) {
                    //alert("Value " + values[i]);
                    //debugger;
                    CheckedId1 = values;
                    selectedRecordCount = i;
                    //alert(i);
                    document.getElementById("<%= hidAnalysisId.ClientID %>").value = values[i];
                    //alert(values[i]);
                }
            } finally {

            }
        }


        //var CheckedId2 = [];
        function gvRejectedAnalysis_SelectionChanged(s, e) {
            s.GetSelectedFieldValues("Id", GetSelectedFieldValuesCallback2);
        }
        function GetSelectedFieldValuesCallback2(values) {
            try {
                for (var i = 0; i < values.length; i++) {
                    //alert("Value" + values[i]);
                    //debugger;
                    document.getElementById("<%= hidRejectedAnalysisId.ClientID %>").value = values[i];
                }
            } finally {

            }
        }

        function gvSaveInDraft_SelectionChanged(s, e) {
            s.GetSelectedFieldValues("Id", GetSelectedFieldValuesCallback3);
        }
        function GetSelectedFieldValuesCallback3(values) {
            try {
                for (var i = 0; i < values.length; i++) {
                    //alert("Value" + values[i]);
                    //debugger;
                    document.getElementById("<%= hidSaveInDraftAnalysisId.ClientID %>").value = values[i];
                }
            } finally {

            }
        }



        $(document).ready(function () {
            //debugger;
            $("#tabs").tabs();
            var st = $(this).find("input[id*='hidtab']").val();
            if (st == null)
                st = 0;

            $("#tabs").tabs({ active: st });
            //$("#tabs").tabs({
            //    select: function (event, ui) {
            //        alert("PRESSED TAB!");
            //    }
            //});
            var AnalysisStatus = document.getElementById("<%=hidAnalysisState.ClientID %>"); //$(this).find("input[id*='hidAnalysisState']").val();
            if (AnalysisStatus.value == "False") {
                var divreject = document.getElementById("tabs-3");
                var lireject = document.getElementById("liRejected");
                divreject.style.display = "none";
                lireject.style.display = "none";

                var val1 = document.getElementById("liPending");
                val1.text = "Approved Records";

            }

        });
    </script>

    <script type="text/javascript" src="scripts/date.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.12.1.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui.js"></script>



    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    <% Response.ExpiresAbsolute = DateTime.Now;%><div class="page-title">Scenario Main</div>
    <asp:HiddenField ID="hidConfrimValue" runat="server" />
    <dx:ASPxPageControl ID="AnalysisTab" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Text="Pending For Approval">
                <ContentCollection>
                    <dx:ContentControl>
                        <table class="custom-table">
                            <tr>
                                <td>
                                    <div>
                                        <dxe:ASPxButton ID="ASPxButtonExport" runat="server" Text="Export"  OnClick="ASPxButtonExport_Click"></dxe:ASPxButton>
                                    </div>
                                    <dx:ASPxGridView ID="gvAnalyses" runat="server" ClientInstanceName="gvAnalyses" Width="100%" KeyFieldName="AnalysisId"
                                        Styles-Header-CssClass="custom-table-header" OnCustomUnboundColumnData="gvAnalyses_CustomUnboundColumnData"
                                        AutoGenerateColumns="False" OnHtmlDataCellPrepared="gvAnalyses_HtmlDataCellPrepared" OnLoad="gvAnalyses_Load" SettingsText-EmptyDataRow="No Record Found">
                                        <SettingsBehavior AllowFocusedRow="false" ColumnResizeMode="Control" />
                                        <Columns>
                                            <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="true" Width="30px">
                                                <ClearFilterButton Visible="True">
                                                </ClearFilterButton>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="Download" Width="90px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkDownload" Text="Download" runat="server"
                                                        OnCommand="lnkDownload_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>
                                               <dx:GridViewDataTextColumn FieldName="Title" Caption="Scenario Number"
                                                 VisibleIndex="2" Width="145px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ShortName" Caption="Scenario Name"
                                                 VisibleIndex="3" Width="300px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="PrimaryOwner" Caption="PrimaryOwner"
                                                 VisibleIndex="4" Width="90px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="IAUnit" Caption="IAUnit"
                                                 VisibleIndex="5" Width="150px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            
                                              <dx:GridViewDataTextColumn FieldName="IASubUnit" Caption="IASubUnit"
                                                 VisibleIndex="6" Width="90px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>


                                               <dx:GridViewDataTextColumn FieldName="Frequency" Caption="Frequecy"
                                                 VisibleIndex="7" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                               <dx:GridViewDataTextColumn FieldName="Category" Caption="Category"
                                                 VisibleIndex="8" Width="150px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                             <dx:GridViewDataTextColumn FieldName="SubCategory1" Caption="SubCategory1"
                                                 VisibleIndex="9" Width="100px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="MasterInfo.CreatedOn" Caption="DateOfCreation"
                                                 VisibleIndex="10" Width="120px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="CreatedByUser" Caption="Created By"
                                                 VisibleIndex="11" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                                  <dx:GridViewDataTextColumn FieldName="ModifiedByUser" Caption="Modified By"
                                                 VisibleIndex="12" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="MasterInfo.ModifiedOn" Caption="Modified Date"
                                                 VisibleIndex="13" Width="120px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="ResponseType" Caption="ResponseType"
                                                 VisibleIndex="14" Width="150px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="ScenerioStatus" Caption="Scenario Status"
                                                Visible="true"  VisibleIndex="15">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            
                                            <dx:GridViewDataTextColumn FieldName="Status" Caption="Status"
                                                Visible="false"  VisibleIndex="15">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            
                                             <dx:GridViewDataTextColumn FieldName="Reportname" Caption="Report Id"
                                                 VisibleIndex="16">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataColumn Caption="Report Format" Width="125px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkExport" Text="Report Format" runat="server"
                                                        OnCommand="lnkExport_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>

                                            <dx:GridViewDataTextColumn FieldName="Number" Caption="Serial No." VisibleIndex="2" Visible="false"
                                                SortOrder="Ascending" UnboundType="String" HeaderStyle-ForeColor="#732678" Width="50px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="AnalysisId" Caption="Scenario Id" VisibleIndex="2" Visible="false"
                                                HeaderStyle-ForeColor="#732678" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                         
                                                                          
                                            <dx:GridViewDataTextColumn FieldName="Profiles" Caption="Profiles" Visible="false"
                                                 VisibleIndex="6">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                         


<%--                                            <dx:GridViewDataTextColumn FieldName="Parameters" Caption="Parameters"
                                                Visible="false"  VisibleIndex="8">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Users" Caption="Users"
                                                Visible="false"  VisibleIndex="9">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                          
                                            <dx:GridViewDataTextColumn FieldName="AnalysisStatus" Caption="Status"
                                                Visible="true"  VisibleIndex="11" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>

                                            <%-- <dx:GridViewDataTextColumn FieldName="InputerName" Caption="InputerName"
                                                 VisibleIndex="12" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                         
                                            <%--<dx:GridViewDataTextColumn FieldName="MasterInfo.CreatedOn" Caption="Created Date"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                          
                                            <dx:GridViewDataTextColumn FieldName="ApprovedBy" Caption="ApprovedBy"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                         
                                            <dx:GridViewDataTextColumn FieldName="ApprovedOn" Caption="Approved On"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <%--<dx:GridViewDataTextColumn FieldName="ReportFields" Caption="ReportField"
                                                 VisibleIndex="14" Width="50%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                        </Columns>
                                        <SettingsPager Position="Bottom" AlwaysShowPager="True" PageSize="10">
                                            <PageSizeItemSettings Items="10,20,30" ShowAllItem="false" ShowPopupShadow="False" Visible="True"></PageSizeItemSettings>
                                        </SettingsPager>
                                        <ClientSideEvents SelectionChanged="gvAnalyses_SelectionChanged" />
                                        <Settings ShowHorizontalScrollBar="true" ShowVerticalScrollBar="true" VerticalScrollableHeight="250"
                                            ShowFilterRow="True" HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" />

                                        <SettingsText EmptyDataRow="No Record Found"></SettingsText>

                                        <SettingsDetail ExportMode="All" />
                                        <Styles>
                                            <Header CssClass="custom-table-header"></Header>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <SettingsBehavior AllowSelectSingleRowOnly="false" />
                                    </dx:ASPxGridView>
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="gvAnalyses"></dx:ASPxGridViewExporter>
                                    <%--<asp:Label ID="lblNoAnalysisMessage" Visible="false" Text="No Analyses Found" runat="server" />--%>
                                    <asp:HiddenField ID="hidAnalysisId" runat="server" />
                                    <asp:HiddenField ID="hidComments" runat="server" />
                                    <asp:HiddenField ID="hidAnalysisState" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
        
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>

            <dx:TabPage Text="Rejected">
                <ContentCollection>
                    <dx:ContentControl>
                        <table class="custom-table">
                            <tr>
                                <td>
                                    <div>
                                        <dxe:ASPxButton ID="ASPxBtnRejected" runat="server" Text="Export" Visible="false" OnClick="ASPxBtnRejected_Click"></dxe:ASPxButton>
                                    </div>
                                    <dx:ASPxGridView ID="gvRejectedAnalysis" runat="server" Width="100%"
                                        KeyFieldName="Id"
                                        Styles-Header-CssClass="custom-table-header"
                                        AutoGenerateColumns="False"
                                        OnLoad="gvRejectedAnalysis_Load"
                                        OnCustomUnboundColumnData="gvRejectedAnalysis_CustomUnboundColumnData">
                                        <SettingsBehavior AllowFocusedRow="false" ColumnResizeMode="Control" />
                                        <Columns>
                                            <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="true" Width="30px">
                                                <ClearFilterButton Visible="True">
                                                </ClearFilterButton>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="Download" Width="90px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkDownload" Text="Download" runat="server"
                                                        OnCommand="lnkDownload_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>


                                            <dx:GridViewDataTextColumn FieldName="Title" Caption="Scenario Number"
                                                 VisibleIndex="2" Width="180px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                                 
                                            <dx:GridViewDataTextColumn FieldName="ShortName" Caption="Scenario Name"
                                                 VisibleIndex="3" Width="250px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="PrimaryOwner" Caption="Primary Owner"
                                                 VisibleIndex="4" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="IAUnit" Caption="IAUnit"
                                                 VisibleIndex="5" Width="150px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="IASubUnit" Caption="IASubUnit"
                                                 VisibleIndex="6" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>


                                              <dx:GridViewDataTextColumn FieldName="Frequency" Caption="Frequecy"
                                                 VisibleIndex="7" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                             <dx:GridViewDataTextColumn FieldName="Category" Caption="Category"
                                                 VisibleIndex="8" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            
                                              <dx:GridViewDataTextColumn FieldName="SubCategory1" Caption="SubCategory1"
                                                 VisibleIndex="8" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                                 
                                              <dx:GridViewDataTextColumn FieldName="DateOfCreation" Caption="DateOfCreation"
                                                 VisibleIndex="9" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                                    
                                              <dx:GridViewDataTextColumn FieldName="CreatedByUser" Caption="CreatedBy"
                                                 VisibleIndex="10" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="InputerName" Caption="ModifiedBy"
                                                 VisibleIndex="11" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="ModifiedDateTime" Caption="ModifiedOn"
                                                 VisibleIndex="12" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="ResponseType" Caption="ResponseType"
                                                 VisibleIndex="13" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn FieldName="ScenerioStatus" Caption="Scenario Status"
                                                Visible="true"  VisibleIndex="14" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                                                           

                                            <dx:GridViewDataTextColumn FieldName="Reportname" Caption="Report Id"
                                                 VisibleIndex="15" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Number" Caption="Serial No." VisibleIndex="1" Visible="false"
                                                SortOrder="Ascending" UnboundType="String" CellStyle-ForeColor="#732678" HeaderStyle-ForeColor="#732678" Width="50px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Id" Caption="Scenario Id" VisibleIndex="2" Visible="false"
                                                >
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
            
                                       
                                        </Columns>
                                        <SettingsPager Position="Bottom" AlwaysShowPager="True" PageSize="10">
                                            <PageSizeItemSettings Items="10,20,30" ShowAllItem="false" ShowPopupShadow="False" Visible="True"></PageSizeItemSettings>
                                        </SettingsPager>
                                        <SettingsDetail ExportMode="All" />
                                        <SettingsBehavior AllowSelectSingleRowOnly="false" />
                                        <Settings ShowHorizontalScrollBar="true" ShowVerticalScrollBar="true" VerticalScrollableHeight="250"
                                            ShowFilterRow="True" />
                                        <Styles>
                                            <Header CssClass="custom-table-header"></Header>
                                        </Styles>
                                        <ClientSideEvents SelectionChanged="gvRejectedAnalysis_SelectionChanged" />
                                    </dx:ASPxGridView>
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter2" runat="server" GridViewID="gvRejectedAnalysis"></dx:ASPxGridViewExporter>
                                    <%--<asp:Label ID="lblRejectedAnalysisMsg" Visible="false" Text="No Analyses Found" runat="server" />--%>
                                    <asp:HiddenField ID="hidRejectedAnalysisId" runat="server" />
                                    <asp:HiddenField ID="hidExitsInBoth" runat="server" />
                                    <asp:HiddenField ID="hidCMgs" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>

            <dx:TabPage Text="Draft">
                <ContentCollection>
                    <dx:ContentControl>
                        <table class="custom-table">
                            <tr>
                                <td style="text-align: left; border: groove; border-width: 0.5px; background-color: lightsteelblue; white-space: nowrap;">
                                    <div>
                                        <dxe:ASPxButton ID="ASPxButton1" runat="server" Text="Export" Visible="false" OnClick="ASPxButton1_Click"></dxe:ASPxButton>
                                    </div>
                                    <dx:ASPxGridView ID="gvSaveInDraft" runat="server" ClientInstanceName="gvSaveInDraft" Width="100%" KeyFieldName="AnalysisId"
                                        Styles-Header-CssClass="custom-table-header" OnCustomUnboundColumnData="gvSaveInDraft_CustomUnboundColumnData"
                                        AutoGenerateColumns="False" OnHtmlDataCellPrepared="gvSaveInDraft_HtmlDataCellPrepared" OnLoad="gvSaveInDraft_Load"
                                        SettingsText-EmptyDataRow="No Record Found">
                                        <SettingsBehavior AllowFocusedRow="false" ColumnResizeMode="Control" />
                                        <Columns>
                                            <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="true" Width="30px">
                                                <ClearFilterButton Visible="True">
                                                </ClearFilterButton>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="Download" Width="80px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkDownload" Text="Download" runat="server"
                                                        OnCommand="lnkDownload_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>
                                               <dx:GridViewDataTextColumn FieldName="Title" Caption="Scenario Number"
                                                 VisibleIndex="2" Width="180px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ShortName" Caption="Scenario Name"
                                                 VisibleIndex="3" Width="300px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="PrimaryOwner" Caption="PrimaryOwner"
                                                 VisibleIndex="4" Width="90px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="IAUnit" Caption="IAUnit"
                                                 VisibleIndex="5" Width="150px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            
                                              <dx:GridViewDataTextColumn FieldName="IASubUnit" Caption="IASubUnit"
                                                 VisibleIndex="6" Width="90px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>


                                               <dx:GridViewDataTextColumn FieldName="Frequency" Caption="Frequecy"
                                                 VisibleIndex="7" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                               <dx:GridViewDataTextColumn FieldName="Category" Caption="Category"
                                                 VisibleIndex="8" Width="150px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                             <dx:GridViewDataTextColumn FieldName="SubCategory1" Caption="SubCategory1"
                                                 VisibleIndex="9" Width="100px" CellStyle-Wrap="True">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="MasterInfo.CreatedOn" Caption="DateOfCreation"
                                                 VisibleIndex="10" Width="120px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                              <dx:GridViewDataTextColumn FieldName="CreatedByUser" Caption="Created By"
                                                 VisibleIndex="11" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                                  <dx:GridViewDataTextColumn FieldName="ModifiedByUser" Caption="Modified By"
                                                 VisibleIndex="12" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="MasterInfo.ModifiedOn" Caption="Modified Date"
                                                 VisibleIndex="13" Width="120px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="ResponseType" Caption="ResponseType"
                                                 VisibleIndex="14" Width="150px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                               <dx:GridViewDataTextColumn FieldName="ScenerioStatus" Caption="Scenario Status"
                                                Visible="true"  VisibleIndex="15" Width="100px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <%--<dx:GridViewDataTextColumn FieldName="Status" Caption="Status"
                                                Visible="false"  VisibleIndex="15">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>

                                            
                                             <dx:GridViewDataTextColumn FieldName="Reportname" Caption="Report Id"
                                                 VisibleIndex="16">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataColumn Caption="Report Format" Width="125px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkExport" Text="Report Format" runat="server"
                                                        OnCommand="lnkExport_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>

                                            <dx:GridViewDataTextColumn FieldName="Number" Caption="Serial No." VisibleIndex="2" Visible="false"
                                                SortOrder="Ascending" UnboundType="String" HeaderStyle-ForeColor="#732678" Width="50px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="AnalysisId" Caption="Scenario Id" VisibleIndex="2" Visible="false"
                                                HeaderStyle-ForeColor="#732678" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                         
                                                                          
                                            <dx:GridViewDataTextColumn FieldName="Profiles" Caption="Profiles" Visible="false"
                                                 VisibleIndex="6">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                         


<%--                                            <dx:GridViewDataTextColumn FieldName="Parameters" Caption="Parameters"
                                                Visible="false"  VisibleIndex="8">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Users" Caption="Users"
                                                Visible="false"  VisibleIndex="9">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                          
                                            <dx:GridViewDataTextColumn FieldName="AnalysisStatus" Caption="Status"
                                                Visible="true"  VisibleIndex="11" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>

                                            <%-- <dx:GridViewDataTextColumn FieldName="InputerName" Caption="InputerName"
                                                 VisibleIndex="12" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                         
                                            <%--<dx:GridViewDataTextColumn FieldName="MasterInfo.CreatedOn" Caption="Created Date"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                          
                                            <dx:GridViewDataTextColumn FieldName="ApprovedBy" Caption="ApprovedBy"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                         
                                            <dx:GridViewDataTextColumn FieldName="ApprovedOn" Caption="Approved On"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <%--<dx:GridViewDataTextColumn FieldName="ReportFields" Caption="ReportField"
                                                 VisibleIndex="14" Width="50%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>--%>
                                        </Columns>
                                        <%--<Columns>
                                            <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="true" Width="30px">
                                                <ClearFilterButton Visible="True">
                                                </ClearFilterButton>
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="Download" Width="90px"
                                                 VisibleIndex="1">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkDownload" Text="Download" runat="server"
                                                        OnCommand="lnkDownload_Command" CommandName='<%#Eval("Reportname")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Report Format" Width="90px" Visible="true"
                                                 VisibleIndex="2">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lnkExport" Text="Report Format" runat="server"
                                                        OnCommand="lnkExport_CommandForDraft" CommandName='<%#Eval("Id")%>' CommandArgument='<%# String.Format("ReportFields={0}&Reportname={1}", DataBinder.Eval(Container.DataItem, "ReportFields"), DataBinder.Eval(Container.DataItem, "Reportname")) %>'></asp:LinkButton>
                                                    
                                                </DataItemTemplate>
                                                <HeaderStyle></HeaderStyle>
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataTextColumn FieldName="Number" Caption="Serial No." VisibleIndex="3"
                                                SortOrder="Ascending" UnboundType="String" HeaderStyle-ForeColor="#732678" Width="50px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="AnalysisId" Caption="Scenario Id" VisibleIndex="4"
                                                HeaderStyle-ForeColor="#732678" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                            </dx:GridViewDataTextColumn>
                                                  <dx:GridViewDataTextColumn FieldName="Title" Caption="Scenario Number"
                                                 VisibleIndex="4" Width="50%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ShortName" Caption="Short Name"
                                                 VisibleIndex="5" Width="50%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Reportname" Caption="Report Name"
                                                 VisibleIndex="6">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                                                  
                                            <dx:GridViewDataTextColumn FieldName="Profiles" Caption="Profiles"
                                                 VisibleIndex="7">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Frequency" Caption="Frequecy"
                                                 VisibleIndex="8" Width="60px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>


                                            <dx:GridViewDataTextColumn FieldName="Parameters" Caption="Parameters"
                                                Visible="false"  VisibleIndex="9">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Users" Caption="Users"
                                                Visible="false"  VisibleIndex="10">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataTextColumn FieldName="Status" Caption="Status"
                                                Visible="false"  VisibleIndex="11">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="AnalysisStatus" Caption="Status"
                                                Visible="true"  VisibleIndex="11" Width="80px">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="MasterInfo.ModifiedOn" Caption="Modified Date"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CreatedByUser" Caption="Created By"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="ModifiedByUser" Caption="Modified By"
                                                 VisibleIndex="13" Width="25%">
                                                <HeaderStyle></HeaderStyle>
                                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                <CellStyle></CellStyle>
                                            </dx:GridViewDataTextColumn>

                                        
                                        </Columns>--%>
                                        <SettingsPager Position="Bottom" AlwaysShowPager="True" PageSize="10">
                                            <PageSizeItemSettings Items="10,20,30" ShowAllItem="false" ShowPopupShadow="False" Visible="True"></PageSizeItemSettings>
                                        </SettingsPager>
                                        <ClientSideEvents SelectionChanged="gvAnalyses_SelectionChanged" />
                                        <Settings ShowHorizontalScrollBar="true" ShowVerticalScrollBar="true" VerticalScrollableHeight="250"
                                            ShowFilterRow="True" HorizontalScrollBarMode="Visible" VerticalScrollBarMode="Visible" />

                                        <SettingsText EmptyDataRow="No Record Found"></SettingsText>

                                        <SettingsDetail ExportMode="All" />
                                        <Styles>
                                            <Header CssClass="custom-table-header"></Header>
                                            <AlternatingRow Enabled="true" />
                                        </Styles>
                                        <SettingsBehavior AllowSelectSingleRowOnly="false" />
                                    </dx:ASPxGridView>
                                    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter3" runat="server" GridViewID="gvSaveInDraft"></dx:ASPxGridViewExporter>
                                    
                                    <asp:HiddenField ID="hidSaveInDraftAnalysisId" runat="server" />
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>

                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>

        </TabPages>
    </dx:ASPxPageControl>
    <center>
        <table>
            <tr>
                <td>
                    <tr>
                        <td>
                            <center>
                                <asp:Button ID="cmdNew" runat="server" Text="New" CssClass="form-button" OnClick="cmdNew_Click"></asp:Button>
                                <div runat="server" id="divApprove" visible="false">
                                    <asp:Button ID="cmdCompare" runat="server" Visible="false" Text="Compare with Previous Analysis" CssClass="form-button" Width="250px" OnClick="cmdCompare_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="cmdApprove" runat="server" Visible="false" Text="Open" CssClass="form-button" OnClick="cmdModify_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="cmdApproveAll" runat="server" Visible="false" Text="Approve Selected" CssClass="form-button" Width="150px" OnClientClick="return CheckerAction(this,'Approve')" OnClick="cmdApproveAll_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="cmdRejectAll" runat="server" Visible="false" Text="Reject Selected" CssClass="form-button" Width="150px" OnClientClick="return CheckerAction(this,'Reject'); " OnClick="cmdRejectAll_Click" />&nbsp;&nbsp;
                                </div>
                                <asp:Button ID="cmdModify" runat="server" Text="Modify" CssClass="form-button"  OnClick="cmdModify_Click"  OnClientClick="return CheckRowToModify('modify');"></asp:Button><%--OnClientClick="return CheckAllRows('modify');"--%>
                                <asp:Button ID="cmdView" runat="server" Text="View" Visible="false" CssClass="form-button"  OnClick="cmdView_Click"  OnClientClick="return CheckRowToModify('view');"></asp:Button>
                                <asp:Button ID="cmdDelete" runat="server" Text="Delete" CssClass="form-button" OnClientClick="return CheckRowToModify('delete');" OnClick="cmdDelete_Click"></asp:Button><%--OnClientClick="return confirm_message;"--%>
                            </center>
                        </td>
                    </tr>
                </td>
            </tr>
        </table>
    </center>
    <script type="text/javascript">
        function SelectRow() {
            var obj = window.event.srcElement;
            if (obj.tagName == "INPUT")    //this is a checkbox
            {
                checkRowOfObject(obj);
            }
            else if (obj.tagName == "TD") //this a table cell
            {
                //get a pointer to the tablerow
                var row = obj.parentNode;
                var chk = row.cells[0].getElementsByTagName("input");
                chk.checked = !chk.checked;
                if (chk.checked) {
                    row.className = "parameter-green";
                }
                else {
                    row.className = "parameter-red";
                }
            }
        }
        function checkRowOfObject(obj) {
            if (obj.checked) {
                obj.parentNode.parentNode.className = "parameter-green";
            }
            else {
                obj.parentNode.parentNode.className = "parameter-red";
            }
        }

        function SelectAllRows() {
            var gridview = document.getElementById("<%= gvAnalyses.ClientID %>");
            var MainCheckval = gridview.rows[0].cells[0].getElementsByTagName("INPUT")[0].checked;
            for (var i = 1; i < gridview.rows.length - 1; i++) {

                if (gridview.rows[i].cells[0].getElementsByTagName("INPUT")[0].disabled == false) {
                    gridview.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = MainCheckval;
                }
            }
        }

        function CheckRowToModify(msg) {
            //debugger;
            var checkeditems = 0;
            if (document.getElementById("<%= hidAnalysisId.ClientID %>").value != "") {
                var checkeditems = document.getElementById("<%= hidAnalysisId.ClientID %>").value;
            }

            if (document.getElementById("<%= hidRejectedAnalysisId.ClientID %>").value != "") {
                var checkeditems = document.getElementById("<%= hidRejectedAnalysisId.ClientID %>").value;
            }

            if (document.getElementById("<%= hidSaveInDraftAnalysisId.ClientID %>").value != "") {
                var checkeditems = document.getElementById("<%= hidSaveInDraftAnalysisId.ClientID %>").value;
             }



            if (checkeditems < 1) {
                alert("Atleast select a item to " + msg);
                return false;
            }

            if (msg = 'view') {
                return true;
            }

            if (msg == 'delete') {

                if (selectedRecordCount > 0) {
                    alert("You can not Delete multiple records at a time.");
                    return false;
                }

                var x = confirm("Are you sure to delete?");
                if (x)
                    return true;
                else
                    return false;
            }

         


            if (msg == 'modify') {
                //debugger;

                if (selectedRecordCount > 0) {
                    alert("You can not Update multiple records at a time.");
                    return false;
                }


                if (checkeditems < 1) {
                    alert("Atleast select a item from Approved / Rejected to " + msg);
                    return false;
                }
                else {
                    var x = confirm("Are you sure to Modify selected Record ?");
                    if (x) {
                        //alert(x);
                        //return true;
                        //alert(IsExistsBoth);
                        if (x == true) {
                            //debugger;
                            //var IsExistsBoth = '';
                            PageMethods.CheckExists(checkeditems, function (response) {
                                //debugger;

                                if (response == 'true') {

                                    alert("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?");

                                    //var x = confirm("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?");
                                    //debugger;
                                    //if (x) {
                                    //    //alert(x);
                                    //    debugger;
                                    //    return true;
                                    //}
                                    //else {
                                    //    //alert(x);
                                    //    debugger;
                                    //    alert('Cancelled');
                                    //    return false;
                                    //}

                                }
                            });
                        }
                    }
                    else {
                        //alert(x);
                        alert('Cancelled');
                        return false;
                    }
                }
            }

            //var confirm_value = document.createElement("INPUT");
            //confirm_value.type = "hidden";
            //confirm_value.name = "confirm_value";

            <%--if (msg == 'modify') {
                var confirm_value = "";
                //var confirm_value = document.createElement("INPUT");
                //confirm_value.type = "hidden";
                //confirm_value.name = "confirm_value";
                PageMethods.CheckExists(checkeditems, function (response) {
                    debugger;
                    //var message = document.getElementById("<%= hidExitsInBoth.ClientID %>").value;
                    //alert(message);
                    //alert(response);
                    if (response == 'true') {
                        debugger;
                        var x = confirm("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?");
                        if (x) {
                            //alert(x);
                            debugger;
                            confirm_value = x
                            //return true;
                        }
                        else {
                            //alert(x);
                            debugger;
                            confirm_value = x;
                            alert('Cancelled');
                            //return false;
                        }
                        //document.forms[0].appendChild(confirm_value);
                    }
                    debugger;
                    if (confirm_value == false) {
                        return false;
                    }
                });
                
            }--%>

        }

        function Prompt() {
            //debugger
            Comment = prompt("Please enter Comment:", "");
            if (Comment == "") {
                //debugger
                Prompt();
                // return false;
            }
            else {
                return false;
            }
        }
        function CheckerAction(approveuserdetail, Action) {
            //debugger
            if (CheckedId1.length > 0) {
                if (confirm("Are you sure want to " + Action)) {
                    var Comment = prompt("Please enter Comment:", "");
                    {
                        
                        if (Comment === null) {
                            alert('Cancelled');
                            return false;
                        }

                        if (Comment.trim() == "") {
                            alert('Comment is Mandatory!');
                            return false;
                        }



                        document.getElementById("<%= hidComments.ClientID %>").value = Comment;
                    }


                }
                else {
                    return false;
                }
            }
            else {
                alert("Select atleast one item to " + Action)
            }
        }



        <%--alert(response);


            //PageMethods.CheckExists(checkeditems,Success, Failure); 

            //document.getElementById("<%= hidExitsInBoth.ClientID %>").value = "Yes";

            //var status = '';
            //$.ajax({
            //    type: "POST",
            //    url: "AnalysisMain.aspx/CheckExists", // this for calling the web method function in cs code.  
            //    data: '{Id: ' + checkeditems + ' }',// user name or email value  
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (data) {
            //        alert("Under success");
            //        var result = data.d;

            //        if (result == 'true') {
            //            status = Confirm();

            //            if (status == "No") {
            //                $("#hidExitsInBoth").val("No");
            //            }
                        
            //        }
                    
            //    }
                 
            //});



           var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?")) {
                confirm_value.value = "Yes";
                document.getElementById("<%= hidExitsInBoth.ClientID %>").value = "Yes";
            } else {
                confirm_value.value = "No";
                document.getElementById("<%= hidExitsInBoth.ClientID %>").value = "No";
            }
            document.forms[0].appendChild(confirm_value);


        function Success(result) {
            alert("Success Result  " + result);

            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";

            if (result == 'true') {
                if (confirm("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?")) {
                    confirm_value.value = "Yes";
                    document.getElementById("<%= hidExitsInBoth.ClientID %>").value = "Yes";
                } else {
                    confirm_value.value = "No";
                    document.getElementById("<%= hidExitsInBoth.ClientID %>").value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
        }

        function Failure(error) {
            alert(error);
        }

       function ConfirmRejected() {
            var x = confirm("Are you sure to modify record it will overwrite to existig record which will avaliale in both Approved / Rejected ,Please confirm which record you want update ?")
            document.getElementById("<%= hidExitsInBoth.ClientID %>").value = x;
            //document.getElementById("Button2").click();
            return false;
        }
        --%>


    </script>
</asp:Content>

