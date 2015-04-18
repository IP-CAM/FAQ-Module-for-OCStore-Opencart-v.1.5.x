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
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
    <div class="heading">
		<h1><img src="view/image/faq.png" alt="" style="height:30px;"/> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="location = '<?php echo $module; ?>';" class="button"><span><?php echo $button_module; ?></span></a>
			<a onclick="location = '<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a>
			<a onclick="$('#form').submit();" class="button"><span><?php echo $button_delete; ?></span></a>
		</div>
    </div>
    <div class="content">
		<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
			<thead>
            <tr>
				<td width="1" align="center"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
				<td class="left"><?php echo $column_title; ?> (<?php echo $totalfaq; ?>)</td>
				<td class="left"><?php echo $column_date_added; ?></td>
				<td class="left"><?php echo $column_viewed; ?></td>
				<td class="left"><?php echo $column_status; ?></td>
				<td class="right"><?php echo $column_action; ?></td>
            </tr>
			</thead>
			<tbody>
            <?php if ($faq) { ?>
				<?php $class = 'odd'; ?>
				<?php foreach ($faq as $faq_story) { ?>
				<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
				<tr class="<?php echo $class; ?>">
					<td align="center">
						<?php if ($faq_story['selected']) { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $faq_story['faq_id']; ?>" checked="checked" />
						<?php } else { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $faq_story['faq_id']; ?>" />
						<?php } ?>
					</td>
					<td class="left"><?php echo $faq_story['title']; ?></td>
					<td class="left"><?php echo $faq_story['date_added']; ?></td>
					<td class="left"><?php echo $faq_story['viewed']; ?></td>
					<td class="left"><?php echo $faq_story['status']; ?></td>
					<td class="right">
						<?php foreach ($faq_story['action'] as $action) { ?> [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ] <?php } ?>
					</td>
				</tr>
				<?php } ?>
            <?php } else { ?>
				<tr class="even">
					<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
				</tr>
            <?php } ?>
          </tbody>
        </table>
		</form>
        <div class="pagination"><?php echo $pagination; ?></div>
        <br /><div style="text-align: center"><?php echo $faq_version; ?></div>
    </div>
	</div>
</div>
<?php echo $footer; ?>