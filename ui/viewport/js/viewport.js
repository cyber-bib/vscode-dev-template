// #region viewport {
	function viewport(
		status_id = "em-status",
		progress_id = "em-progress",
		spinner_id = "em-spinner",
		canvas_id = "em-canvas",
		output_id = "em-output"
	) {
		// #region variables
			this.preRun = [];
			this.postRun = [];
			this.totalDependencies = 0;
			this.status = document.getElementById(status_id);
			this.progress = document.getElementById(progress_id);
			this.spinner = document.getElementById(spinner_id);
			this.canvas = document.getElementById(canvas_id);
			this.output = document.getElementById(output_id);
		// #endregion variables
		// #region functions {
			// #region update-canvas {
				this.updateWidth = function () {
					var val;
					val = Math.floor(0.99 * window.innerWidth - 4);
					this.canvas.width = val;
					return val;
				};
				this.updateHeight = function () {
					var val;
					val = Math.floor(0.99 * window.innerHeight - 4);
					this.canvas.height = val;
					return val;
				};
				this.updateSize = function () {
					var w, h;
					w = this.updateWidth();
					h = this.updateHeight();
					return [w, h];
				};
			// #endregion } update-canvas
			// #region print, printErr, setStatus {
				this.print = (function () {
					if(this.output) {
						return function(text) {
							if(arguments.length > 1) {
								text = Array.prototype.slice.call(arguments).join(' ');
							}
							// These replacements are necessary if you render to raw HTML
							text = text.replace(/&/g, "&amp;");
							text = text.replace(/</g, "&lt;");
							text = text.replace(/>/g, "&gt;");
							text = text.replace('\n', '<br>', 'g');
							// console.log(text);
							if (this.output) {
								this.output.value += text + "\n";
								this.output.scrollTop = this.output.scrollHeight; // focus on bottom
							}
						};
					} else {
						return function (text) {
							if(arguments.length > 1) {
								text = Array.prototype.slice.call(arguments).join(' ');
							}
							console.log(text);
						};	
					}
				})();
				this.printErr = (function() {
					if(true) {
						return function(text) {
							if (arguments.length > 1) {
								text = Array.prototype.slice.call(arguments).join(' ');
							}
							console.error(text);
						}
					} else {
						return function () {
							console.log("printErr called...");
						};
					}
				})();
				this.setStatus = (function () {
					if(this.status && this.progress && this.spinner) {
						return function (text) {
							if(!this.setStatus.last) {
								this.setStatus.last = { time: Date.now(), text: '' };
							}
							if(text === this.setStatus.last.text) {
								return;
							}
							var m = text.match(/([^(]+)\((\d+(\.\d+)?)\/(\d+)\)/);
							var now = Date.now();
							if(m && now - this.setStatus.last.time < 30) {
								return; // if this is a progress update, skip it if too soon
							}
							this.setStatus.last.time = now;
							this.setStatus.last.text = text;
							if (m) {
								text = m[1];
								this.progress.value = parseInt(m[2])*100;
								this.progress.max = parseInt(m[4])*100;
								this.progress.hidden = false;
								this.spinner.hidden = false;
							} else {
								this.progress.value = null;
								this.progress.max = null;
								this.progress.hidden = true;
								if (!text) {
									this.spinner.hidden = true;
								}
							}
							this.status.innerHTML = text;
						};
					} else {
						return function () {
							console.log("setStatus called...");
						};
					}
				})();
			// #endregion } print, printErr, setStatus
			this.monitorRunDependencies = function(left) {
				// this.totalDependencies = Math.max(this.totalDependencies, left);
				// this.setStatus (
				// 	left ?
				// 		'Preparing... (' +v(this.totalDependencies-left) + '/' + this.totalDependencies + ')' :
				// 		'All downloads complete.'
				// );
			}
		// #endregion } functions
		// #region defaults {
			// this.setStatus('Downloading...');
			// #region event listeners {
				// #region on-webglcontextlost {
					this.canvas.addEventListener (
						"webglcontextlost",
						(function(event) {
							alert('WebGL context lost. You will need to reload the page.');
							event.preventDefault();
						}).bind(this),
						false
					);
				// #endregion } on-webglcontextlost
				// #region on-error {
					window.addEventListener (
						"error",
						(function() {
							this.setStatus('Exception thrown, see JavaScript console');
							if(this.spinner) {
								this.spinner.style.display = 'none';
							}
							if(this.status) {
								this.setStatus = function(text) {
									if(text) {
										this.printErr('[post-exception status] ' + text);
									}
								};
							}
						}).bind(this),
						false
					);
				// #endregion } on-error
				// #region on-load {
					window.addEventListener (
						"load",
						(function() {
							this.updateSize();	
						}).bind(this),
						false
					);
				// #endregion } on-load
				// #region on-resize{
					window.addEventListener (
						"resize",
						this.updateSize.bind(this),
						false
					);
				// #endregion } on-resize
			// #endregion event } listeners
		// #endregion } defaults
	};
// #endregion } viewport

var Module = new viewport();
var app = vtkApp(Module);