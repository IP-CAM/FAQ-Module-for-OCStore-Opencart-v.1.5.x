<?php
//-----------------------------------------------------
// Faq Module for Opencart v1.5.5   							
// Modified by morrah      
// http://mocca-web.ru                    			
// webdepo@list.ru                          			
//-----------------------------------------------------
?>

<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
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
		<h1><?php echo $heading_title; ?></h1>
    </div>
    <div>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<input type="hidden" name="faq_store" value="<?php echo $faq_store; ?>"></td>
			<table class="form">
				<tr>
					<td><span class="required">*</span> <?php echo $entry_user_name; ?></td>
					<td><input type="text" name="user_name" value="<?php echo !empty($user_name)?$user_name:''; ?>" size="58" />
						<?php if (isset($error_user_name)) { ?>
							<span class="error"><?php echo $error_user_name; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><span class="required">*</span> <?php echo $entry_title; ?></td>
					<td><input name="faq_description[<?php echo $language['language_id']; ?>][title]" size="58" value="<?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['title'] : ''; ?>" />
						<?php if (isset($error_title[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td><span class="required">*</span> <?php echo $entry_description; ?></td>
					<td><textarea name="faq_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>" cols="60" rows="10"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['description'] : ''; ?></textarea>
						<?php if (isset($error_description[$language['language_id']])) { ?>
							<span class="error"><?php echo $error_description[$language['language_id']]; ?></span>
						<?php } ?>
					</td>
				</tr>
				<tr>
					<td colspan = "2" style="text-align:center;">
						<b><?php echo $entry_captcha; ?></b><br />
						<input type="text" name="captcha" value="<?php echo !empty($captcha)?$captcha:''; ?>" />
						<br />
						<img src="index.php?route=information/faq/captcha" alt="" />
						<?php if ($error_captcha) { ?>
						<span class="error"><?php echo $error_captcha; ?></span>
						<?php } ?>
					</td>
				</tr>
			</table>
		</form>
		<div class="btn-block">
			<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
			<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
    </div>
	</div>
	<?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>