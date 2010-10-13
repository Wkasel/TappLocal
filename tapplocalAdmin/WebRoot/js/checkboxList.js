	var listCheck = new Array();

	function addId(id)
	{
		var exists = false;
	
		for (i=0;i<listCheck.length;i++){
    		if (listCheck[i] == id)
    			 exists = true;
		} 
		
		if (!exists)
			listCheck.push(id);
	
		return true;
	}


	function removeId	(id)
	{	
		for (i=listCheck.length-1; i>=0;i--){
    		if (listCheck[i] == id)
    			 listCheck.splice(i, 1);
		} 	
	
		return true;
	}	