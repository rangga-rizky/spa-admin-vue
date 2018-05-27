export default {
	headers: {
		'Content-Type': 'application/json' ,
		'Authorization' : 'Bearer '+ localStorage.getItem("token"),
	},
}
