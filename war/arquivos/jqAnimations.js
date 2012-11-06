/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {
	
	$(".botao1").click(function() {
		$("form#form1").submit();

	});
	$(".botao2").click(function() {
		$("form#form2").submit();
	});

	$(".itemPai").click(function() {
		$(".filho").show(500);
	});

	$(".filho").mouseover(function() {
		$(".descricao").show(500);
	});
	$(".descricao").click(function() {
		$(".descricao").hide(500);
	});
});
