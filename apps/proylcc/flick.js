// Reference to object provided by pengines.js library which interfaces with Pengines server (Prolog-engine)
// by making query requests and receiving answers.
var pengine;
// Bidimensional array representing grid configuration.
var gridData;
// Bidimensional array with grid cells elements.
var cellElems = null;
// Array with button elements.
var bElems = null;
// Number of turns
var turns = -1;
// Reference to element displaying turns
var turnsElem;
//Lista de ayuda
var helpList;
//Modo panel de colores, en principio deshabilitado hasta iniciar.
/*
	0: modo normal de juego
	1: modo ayuda extra, primero se selecciona un color y luego se brinda la ayuda
	2: botones deshabilitados
*/ 
var modo = 2;
//Comprueba si se inicio o no el juego al cargar la pagina
var ini = 0;

/**
 * Representation of color enumerate as object where each property key defines an enum value (a color), and the
 * associated property value (the string) defines the color name.
 *
 * Values: RED, VIOLET, PINK, GREEN, BLUE, YELLOW
 */

const colors = Object.freeze({
    RED : "red",
    VIOLET : "violet",
    PINK : "pink",
    GREEN : "green",
    BLUE : "blue",
    YELLOW : "yellow"
});

/*
 * Returns the Prolog representation of the received color
 */

function colorToProlog(color) {
    return colors[color].charAt(0);
}

/*
 * Returns the color in colors enum associated to pColor, in Prolog representation.
 */

function colorFromProlog(pColor) {
    for (let color in colors) {
        if (colorToProlog(color) == pColor)
            return color;
    }
    return null;
}

/*
 * Returns the CSS representation of the received color.
 */

function colorToCss(color) {
    return colors[color];
}

/**
* Initialization function. Requests to server, through pengines.js library, 
* the creation of a Pengine instance, which will run Prolog code server-side.
*/

function init() {
    turnsElem = document.getElementById("turnsNum");
    pengine = new Pengine({
        server: "http://localhost:3030/pengine",
        application: "proylcc",
        oncreate: handleCreate,
        onsuccess: handleSuccess,
        destroy: false
    });

    var buttonsPanelElem = document.getElementById("buttonsPanel");
	var i = 0;
	bElems = [];
    for (let color in colors) {
        var buttonElem = document.createElement("button");
        buttonElem.className = "colorBtn";
        buttonElem.style.backgroundColor = colorToCss(color);
        buttonElem.addEventListener("click", function(e) {
			handleColorClick(color);
        });
		buttonElem.setAttribute("id",color);
		bElems[i] = buttonElem;
		i++;
		
        buttonsPanelElem.appendChild(buttonElem);
    }
	
	/*
	Seteo los oyentes de los elementos HTML. 
	*/
	helpElem = document.getElementById("helpButton");
	helpElem.addEventListener("click", function(e) {
		ayuda();
    });
	
	helpElem2 = document.getElementById("helpButton2");
	helpElem2.addEventListener("click", function(e) {
		masayuda();
    });
	
	document.getElementById("ini").addEventListener("click",function(e){
		handleIniciar();
	});		
	
	/*
		Establezco un oyente en los radio buttons, el cual permite obtener una previsualizacion a la hora de inicar el juego.
		Una vez iniciado el juego, el modo ini pasa a 1 y este oyente ya no tiene efecto. 
	*/
	for (let i=0; i < 3; i++) {
		document.getElementById("grid"+(i+1)).addEventListener("click",function(e){
			if(ini == 0){
				pengine.ask("grid("+(i+1)+",Grid)");
				turns = -1;
			}
			
		});
    }
	
	estadoBotones(true);
}

/*
	Oyente del boton "ini". Se encarga de setear la grilla predeterminada elegida por el jugador, y de habilitar los botones para que pueda comenzar a jugar. 
*/

function handleIniciar(){
	
    var val;
    var radios = document.getElementsByName("grid");
    
    // loop through list of radio buttons
    for (var i=0, len=radios.length; i<len; i++) {
        if ( radios[i].checked ) { 
            val = radios[i].value; 
            break; 
        }
    }
	//Seteo el modo en 0, dando lugar a que los botones de colores puedan funcionar. 
	modo = 0;
	//Seteo turnos en -1 para reiniciar el contador. 
	turns = -1;
	//Seteo ini en 1 para deshabilitar la previsualziacion de grillas en los radio buttons. 
	ini = 1;
	//Establezco los cambios en los botones para que ahora figure reiniciar.
	document.getElementById("ini").innerHTML = "Reiniciar";
	document.getElementById("helpMsg").innerHTML = "";
	//Habilito los botones. 
	estadoBotones(false);
	//Realizo la consulta a prolog para que al responder se setee la grilla elegida. 
	pengine.ask('grid('+val+', Grid)');
	
}
	
/**
 * Callback for Pengine server creation
 */
 
function handleCreate() {
    pengine.ask('grid(1, Grid)');
}

/**
 * Callback for successful response received from Pengines server
 */

function handleSuccess(response) {
	
    gridDataTemp = response.data[0].Grid;
	if (gridDataTemp != undefined){
		turns++;
		if (cellElems == null)
			createGridElems(gridDataTemp.length, gridDataTemp[0].length);
		for (let row = 0; row < gridDataTemp.length; row++)
			for (let col = 0; col < gridDataTemp[row].length; col++)
				cellElems[row][col].style.backgroundColor = colorToCss(colorFromProlog(gridDataTemp[row][col]));
		turnsElem.innerHTML = turns;
		gridData = gridDataTemp;
		
		for (let i = 0; i < 6; i++){
			bElems[i].innerHTML = "";		

        }
		
	}
   
   /*
   Verifico si dentro de los parámatros recibios se encuentra la lista con la cantidad de adyacentes agregados. 
   Si el parámetro se encuentra, muestro por pantalla la ayuda en cada uno de los botones de colores. 
   */
   	helpList = response.data[0].ListaAC;

	if (helpList != undefined){
		for (let i = 0; i < 6; i++){
			bElems[i].innerHTML = helpList[i];	
        }
    }

	/*
	Verifico si recibí el parámetro victoria y si es igual a uno.
	En tal caso, quiere decir que hubo una victoria del jugador, por lo que se finaliza esta jugada y se muestra un aviso.
	*/
	var victoria = response.data[0].Victoria;
	if (victoria != undefined){
		if (victoria == 1){
			var helpMsg = document.getElementById("helpMsg");
			helpMsg.innerHTML = "¡Victoria!";
			modo = 2;
			estadoBotones(true);
			
		}
	}
	
	
}

/*
Metodo utilizado para habilitar/deshabilitar botones.
	bool = true se deshabilitan
	bool = false habilitados. 
*/

function estadoBotones(bool){
	helpElem.disabled = bool;
	helpElem2.disabled = bool;
	for (let color in colors) {
		document.getElementById(color).disabled = bool;
    }
}

/**
 * Create grid cells elements
 */

function createGridElems(numOfRows, numOfCols) {
    var gridElem = document.getElementById("grid");
    cellElems = [];
    for (let row = 0; row < numOfRows; row++) {
        cellElems[row] = [];
        for (let col = 0; col < numOfCols; col++) {
            var cellElem = document.createElement("div");
            gridElem.appendChild(cellElem);
            cellElems[row][col] = cellElem;
        }
    }
}

/**
 * Handler for color click. Ask query to Pengines server.
 */

function handleColorClick(color) {
	var helpMsg = document.getElementById("helpMsg");

	if (modo == 0){
		//Modo normal de juego:
		var s = "flick(" + Pengine.stringify(gridData) + "," + Pengine.stringify(colorToProlog(color)) + ",Grid), verificarVictoria(Grid,Victoria)";
		pengine.ask(s);
	} else if (modo == 1){
		//Modo seleccionar color para ayuda adicional
		helpMsg.innerHTML = "";
		modo = 0;	
		helpElem.disabled = false;		
		var s = "ayudaAdicional(" + Pengine.stringify(gridData) + "," + Pengine.stringify(colorToProlog(color)) + ",ListaAC)";
		pengine.ask(s);
	}
    
}

/*
Oyente del boton Mas Ayuda, el cual queda a la espera de un primer color para ofrecer ayuda adicional.

Para esto, seteo el modo en 1, haciendo que el oyente de los botones de colores no cambie la grilla, sino que haga una consulta a ayudaAdicional. 
*/
function masayuda(){
	if (modo == 0){
		var helpMsg = document.getElementById("helpMsg");
		helpMsg.innerHTML = "Seleccione el primer color";
		helpElem.disabled = true;
		modo = 1; //Seteo modo seleccionar color para ayuda adicional
	}
	
		
}

/*
Oyente del boton ayuda. 
Realiza una consulta a prolog, cuyo resultado se mostrara en los botones de colores, indicando la cantidad de celdas que se agregan al conjunto de adyacentes. 
*/
function ayuda(){
	if (modo == 0){
		var s ="ayudaBasica(" + Pengine.stringify(gridData) + ", ListaAC)";
		pengine.ask(s);
	}
}


/**
* Call init function after window loaded to ensure all HTML was created before
* accessing and manipulating it.
*/

window.onload = init;