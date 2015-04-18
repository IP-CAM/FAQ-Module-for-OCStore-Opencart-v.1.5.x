<?php
//-----------------------------------------------------
// Faq Module for Opencart v1.5.5   							
// Modified by morrah      
// http://mocca-web.ru                    			
// webdepo@list.ru                          			
//-----------------------------------------------------
?>

<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<div class="box">
    <div class="heading">
		<h1><img src="view/image/faq.png" alt=""  style="height:30px;"/> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
			<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
    </div>
    <div class="content">
		<div id="tabs" class="htabs">
			<a href="#tab_language"><?php echo $tab_language; ?></a>
			<a href="#tab_setting"><?php echo $tab_setting; ?></a>
		</div>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab_language">
			<div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
				<a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
			</div>
			<?php foreach ($languages as $language) { ?>
			<div id="language<?php echo $language['language_id']; ?>">
				<table class="form">
				<tr>
					<td><span class="required">*</span> <?php echo $entry_title; ?></td>
					<td><input name="faq_description[<?php echo $language['language_id']; ?>][title]" size="80" value="<?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['title'] : ''; ?>" />
						<?php if (isset($error_title[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_meta_description; ?></td>
					<td><textarea name="faq_description[<?php echo $language['language_id']; ?>][meta_description]" cols="80" rows="5"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
				</tr>
				<tr>
					<td><?php echo $entry_meta_keywords; ?></td>
					<td><textarea name="faq_description[<?php echo $language['language_id']; ?>][meta_keywords]" cols="80" rows="5"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['meta_keywords'] : ''; ?></textarea></td>
				</tr>
				<tr>
					<td><span class="required">*</span> <?php echo $entry_description; ?></td>
					<td><textarea name="faq_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['description'] : ''; ?></textarea>
						<?php if (isset($error_description[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_description[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_answerer_id; ?></td>
					<td><input name="faq_description[<?php echo $language['language_id']; ?>][answerer_id]" size="80" value="<?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['answerer_id'] : ''; ?>" />
						<?php if (isset($error_answerer_id[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_answerer_id[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_answerer_name; ?></td>
					<td><input name="faq_description[<?php echo $language['language_id']; ?>][answerer_name]" size="80" value="<?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['answerer_name'] : ''; ?>" />
						<?php if (isset($error_answerer_name[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_answerer_name[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_answer; ?></td>
					<td><textarea name="faq_description[<?php echo $language['language_id']; ?>][answer]" id="answer<?php echo $language['language_id']; ?>"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['answer'] : ''; ?></textarea>
						<?php if (isset($error_answer[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_answer[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				</table>
			</div>
			<?php } ?>
        </div>
        <div id="tab_setting">
			<table class="form">
                <tr>
                    <td><?php echo $entry_pdate; ?></td>
                    <td><input type="text" name="pdate" value="<?php echo $pdate; ?>" size="40" class="date"></td>
                </tr>
				<tr>
					<td><?php echo $entry_user_name; ?></td>
					<td><input type="text" name="user_name" value="<?php echo $user_name; ?>" size="40" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_store; ?></td>
					<td>
						<div id="store_ids" class="scrollbox" style="width:225px;height:60px;">
							<?php $class = 'even'; ?>
							<div class="<?php echo $class; ?>">
								<?php if (in_array(0, $faq_store)) { ?>
									<input type="checkbox" name="faq_store[]" value="0" checked="checked" />
									<?php echo $text_default; ?>
								<?php } else { ?>
									<input type="checkbox" name="faq_store[]" value="0" />
									<?php echo $text_default; ?>
								<?php } ?>
							</div>
							<?php foreach ($stores as $store) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div class="<?php echo $class; ?>">
									<?php if (in_array($store['store_id'], $faq_store)) { ?>
										<input type="checkbox" name="faq_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
										<?php echo $store['name']; ?>
									<?php } else { ?>
										<input type="checkbox" name="faq_store[]" value="<?php echo $store['store_id']; ?>" />
										<?php echo $store['name']; ?>
									<?php } ?>
								</div>
							<?php } ?>
						</div>
						<a onclick="select_all('faq_store', '1');"><?php echo $text_check_all; ?></a> | <a onclick="select_all('faq_store', '0');"><?php echo $text_uncheck_all ?></a>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_keyword; ?></td>
					<td><input type="text" name="keyword" value="<?php echo $keyword; ?>" size="40" /></td>
				</tr>
				<tr style="background:#F8F8F8;">
					<td><?php echo $entry_status; ?></td>
					<td><select name="status">
						<?php if ($status) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>
					</td>
				</tr>
			</table>
        </div>
		</form>
        <br /><div style="text-align: center"><?php echo $faq_version; ?></div>
    </div>
	</div>
</div>

<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
CKEDITOR.replace('answer<?php echo $language['language_id']; ?>', {
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 

<script type="text/javascript"><!--
var formblock;
var forminputs;
 
formblock = document.getElementById('store_ids');
forminputs = formblock.getElementsByTagName('input');
 
function select_all(name, value) {
  for (i = 0; i < forminputs.length; i++) {
    var regex = new RegExp(name, "i");
    if (regex.test(forminputs[i].getAttribute('name'))) {
      if (value == '1') {
        forminputs[i].checked = true;
      } else {
        forminputs[i].checked = false;
	  }
    }
  }
}
//--></script>

<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('#languages a').tabs();
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
//--></script> 

<?php echo $footer; ?>