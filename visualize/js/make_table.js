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
    {title:"Names", field:"Names", responsive: 0, widthGrow: 2, minWidth: 150},
    {
      title:"HADDOCK",
      field:"Haddock",
      description:"HADDOCK score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"FoldX",
      field:"Foldx",
      description:"Foldx score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"FoldXwater",
      field:"Foldxwater",
      description:"Foldxwater score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"EvoEF1",
      field:"Evoef1",
      description:"Evoef1 score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"MutaBind2",
      field:"Mutabind2",
      description:"Mutabind2 score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
    {
      title:"SSIPe",
      field:"Ssipe",
      description:"HADDOCK score. A prediction of how well the proteins interact. Lower scores mean stronger (better) interactions.",
      responsive: 0,
      minWidth: 100
    },
,
  ],

  // Layout
  layout:"fitColumns",
  resizableColumns: false,
  selectable: true,
  columnHeaderVertAlign: "bottom", //align header contents to bottom of cell
  responsiveLayout: "hide",

  tooltipsHeader: getTooltip,
  // pagination: "local",
  // paginationSize: 10,  // model per page.

    // Callbacks
 rowSelected:function(row, column){
   
   var cell = row.getCell(column);
   let modelname = row.getData().Name
   const myArray = modelname.property.split("-");
   let pdbname =  myArray[1] + "_ " + cell + ".pdb"
   let pdburl = "models/" + modelname + "/" + pdbname;
    
   loadMolecule(stage, pdburl)
  },

  rowDeselected: function (row, column){

    var cell = row.getCell(column);
    let modelname = row.getData().Name
    const myArray = modelname.property.split("-");
    let pdbname = myArray[1] + "_ " + cell + ".pdb"
    let pdburl = "models/" + modelname + "/" + pdbname;

    removeMolecule(stage, pdburl)
  },

});
