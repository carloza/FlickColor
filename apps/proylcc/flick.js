// Reference to object provided by pengines.js library which interfaces with Pengines server (Prolog-engine)
// by making query requests and receiving answers.
var pengine;
// Bidimensional array representing grid configuration.
var gridData;
// Bidimensional array with grid cells elements.
var cellElems = null;
// Number of turns
var turns = -1;
// Reference to element displaying turns
var turnsElem;

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

    for (let color in colors) {
        var buttonElem = document.createElement("button");
        buttonElem.className = "colorBtn";
        buttonElem.style.backgroundColor = colorToCss(color);
        buttonElem.addEventListener("click", function(e) {
            handleColorClick(color);
        });
        buttonsPanelElem.appendChild(buttonElem);
    }
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
    gridData = response.data[0].Grid;
    turns++;
    if (cellElems == null)
        createGridElems(gridData.length, gridData[0].length);
    for (let row = 0; row < gridData.length; row++)
        for (let col = 0; col < gridData[row].length; col++)
            cellElems[row][col].style.backgroundColor = colorToCss(colorFromProlog(gridData[row][col]));
    turnsElem.innerHTML = turns;
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
    var s = "flick(" + Pengine.stringify(gridData) + "," + colorToProlog(color) + ",Grid)";
    pengine.ask(s)
}

/**
* Call init function after window loaded to ensure all HTML was created before
* accessing and manipulating it.
*/

window.onload = init;