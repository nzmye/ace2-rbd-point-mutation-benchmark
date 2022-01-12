let getTooltip = function(column){
  let d = column.getDefinition().description;
  if (d) {
    return d
  }

  return false
}

table = new Tabulator("#models-table", {

  // Data
  ajaxURL: "models/models.json",
  ajaxContentType: "json",
  ajaxResponse: function(url, params, response){
    return response;
  },

  // Formatting
  columns: [
    {title:"Mutation Position", field:"Names", responsive: 0, widthGrow: 2, minWidth: 150},
    {
      title:"HADDOCK",
      field:"HADDOCK",
      description:"HADDOCK score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"FoldX",
      field:"FoldX",
      description:"Foldx score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"FoldXwater",
      field:"FoldXwater",
      description:"Foldxwater score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"EvoEF1",
      field:"EvoEF1",
      description:"Evoef1 score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"MutaBind2",
      field:"MutaBind2",
      description:"Mutabind2 score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"SSIPe",
      field:"SSIPe",
      description:"HADDOCK score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
,
  ],

  // Layout
  layout:"fitColumns",
  resizableColumns: false,
  selectable: false,
  columnHeaderVertAlign: "bottom", //align header contents to bottom of cell
  responsiveLayout: "hide",

  tooltipsHeader: getTooltip,
  // pagination: "local",
  // paginationSize: 10,  // model per page.

    // Callbacks
/*  rowSelected:function(row, column){
   
   var cell = row.getCell(column);
   let modelname = row.getData().Names
   alert(modelname)
   alert(cell)
   const myArray = modelname.split("-");
   let pdbname =  myArray[1] + "_ " + cell + ".pdb"
   let pdburl = "models/" + modelname + "/" + pdbname;
    
   loadMolecule(stage, pdburl)
  },
 */
/*   rowDeselected: function (row, column){

    var cell = row.getCell(column);
    let modelname = row.getData().Names
    alert(cell)
    alert(modelname)
    const myArray = modelname.split("-");
    let pdbname = myArray[1] + "_ " + cell + ".pdb"
    let pdburl = "models/" + modelname + "/" + pdbname;

    removeMolecule(stage, pdburl)
  }, */

  cellClick: function (e, cell) {

    var columnname = cell.getColumn().getField()
    var rowname = cell.getRow().getData().Names
   // alert(`The cell has a value of:${row.getData().Names}${column.getField()}${cell.getValue()}`); //display the cells value
    //alert(`The cell has a value of:${rowname}${columnname}${cell.getValue()}`); //display the cells value
  
    let myArray = rowname.split("_");
    let modelname = rowname.replace("_", "-")
    let pdbname = `${myArray[1]}_${columnname}.pdb` 
    let pdburl = `models/${modelname}/${pdbname}`

    //alert(`The cell has a url of:${pdburl}`); //display the cells refer a url

    loadMolecule(stage, pdburl)

  
  },
  
/*   rowClick: function (e, row) {
    var data = row.getData(); //get data object for row

    var cells = row.getCells();

    alert("cell clicked - " + data + cells);

  }, */

});
