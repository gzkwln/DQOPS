# DQOPS
DQ Ops
- Run files 110-125 in SQL - Check next step before running everything
- In the Views scripts replace [SRCSAPECCDEMO] database with your SAP ECC database, this is used basically to create a list of SAP Tables and Fields to select in the app.
- Note, the next step is only necessary if there is no other user table in any other database already that can be used. These two files will catch the user information via API. Ask support for the API user and password. -- Go trough file 150 manually and run 152 before going through the steps of 150 
- SKP > Catalog > Systems > xy > Connections > Create Connections -- usage Profiling, Construct
- Syniti Construct > System Administration > Data Sources -- Add new DataSource with file 200 - and set the created connection in Connection ID and Connector ID
- Syniti Construct > System Administration > WebApps -- Add new WebApp with Excel Integration - File 210 - Validate the WebApp. Remove the Static Page that has been created automatically.
- Syniti Construct > System Administration > WebApps -- Select new WebApp and upload Excel files 220-330 via Excel Integration. Pay attention to file 240 --> Navigate to Admin > Translations > Catalogs not Web App > Catalogs to upload first the Catalog entry and then the phrases. After this, you can run the WebApp Catalog in Syniti Construct > System Administration > WebApps.
- Files 900-910 are manually steps to be performed.
- Clear Cache once done
- The selection page will not work in the beginning because it's linked to a user table which is empty, fill that table using APIs or Manually to test if the selection page is working.
- Check if the Number Range table is properly set to start with.
