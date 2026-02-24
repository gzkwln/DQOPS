README v2 
WRKDQOPS SKPv2   
/*======================================================
1- In the Views 120 to 125 scripts replace [SRCSAPECCDEMO] and SAPECCDEMO database with your SAP ECC database, this is used basically to create a list of SAP Tables and Fields to select in the app.

2- Run files 120-125 in SQL 

3- Note, the next step is only necessary if there is no other user table in any other database already that can be used. These two files will catch the user information via API.
 Ask support for the API user and password. 
	-- Go trough file 150 manually and run 152 before going through the steps of 150 
	-- workaround: Manually insert in SKP_Users table, later construct page. 

4- SKP > Catalog > Systems > <System used for Construct> > Connections > Create Connections -- usage Profiling, Construct

5- SKP > Catalog > Systems > add Datastore WRKDQOPS linked to database WRKDQOPS 

6- Syniti Construct > System Administration > Data Sources 
	-- Add new DataSource with file 200 via excel integration - and set the created connection in Connection ID and Connector ID 
	-- Once created data source, validate, and add SKP Datastore (WRKDQOPS) to vertical view and test connection

7- Syniti Construct > System Administration > WebApps -- Add new WebApp with Excel Integration - File 210 - Validate the WebApp. Remove the Static Page that has been created automatically.

8- Syniti Construct > System Administration > WebApps > DQ Ops > Menu -- Select new WebApp and upload Excel file 230 via Excel Integration. 

9- Syniti Construct > System Administration > WebApps > DQ Ops > Pages -- Select new WebApp > Pages and upload Excel file 220 via Excel Integration. 

10- Admin > Translations > Catalogs -- upload file 240 Catalog via Excel Integration. First upload the Catalog entry and then the phrases. 

11- Admin > Translations > Catalogs > DQOps Catalog Phrases - upload file 250 Catalog Phrases via Excel Integration. 

12- Syniti Construct > System Administration > WebApps > Webapp Catalog -- upload file 260 via Excel Integration.

13- Syniti Construct > System Administration > WebApps > DQ Ops > Groups -- upload file 270 Groups via Excel Integration.

14- Syniti Construct > System Administration > WebApps > DQ Ops > Vertical View > Import/Export > choose the corresponding section for files 280 to 330, e.g. Page Column- upload file 280 Page Column via Excel Integration. do the same for the rest of the files. 

15- Files 900-910 are manually steps to be performed.

16- Clear Cache once done

17- The selection page will not work in the beginning because it's linked to a user table which is empty, fill that table using APIs or Manually to test if the selection page is working.

18- Check if the Number Range table is properly set to start with.

====================================================== */
