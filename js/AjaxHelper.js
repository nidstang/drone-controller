(function() {

	function AjaxHelper(api_url, data_type) {
		this._api_url = api_url;
		this._data_type = data_type;
	};

	AjaxHelper.prototype = {
		trigger: function(url, method, data, _callback) {
			var self = this;
			var request = $.ajax({
			  url: self._api_url + url,
			  type: method,
			  data: data,
			  dataType: self._data_type
			});

			request.done(_callback);
			request.fail(function( jqXHR, textStatus ) {
				console.log(jqXHR.responseText);
			  console.log("Error al procesar la peticion: " + textStatus);
			});
		},

		get: function(url, _before, _callback) {
			_before();
			this.trigger(url, 'GET', {}, _callback);
		},

		post: function(url, data, _before, _callback) {
			_before();
			this.trigger(url, 'POST', data, _callback);
		},
	};


	window.AjaxHelper = AjaxHelper;
})();