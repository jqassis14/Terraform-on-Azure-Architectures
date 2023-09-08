This project is a Multi-Regional Web applicaiton in Azure. 

The project was proposed by ChatGPT, though every line of code is my own, including all code in the "WebAppFiles" folder. 

Components include 

1. Two Azure Resource groups, one in the East US and West US regions
2. Two virtual networks, one in each region. This virtual networks are peered with each other in order to allow for traffic management and communication
3. An app service plan in each region to accommodate a web app deployment to each region
4. A linux web app in each region, using code that is deployed from this repository (see the WebAppFiles folder)
5. An azure traffic manager profile, set with Priority routing. The East US web app will be the primary endpoint and the West US will be the secondary endpoint
   
