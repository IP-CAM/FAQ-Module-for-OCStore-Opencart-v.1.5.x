<?php echo $header; ?>
<?php echo $content_top; ?>
<?php echo $column_left; ?>
<div id="content">
	<?php echo $column_right; ?>
	<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
	</div>
	<?php if(!empty($success)){
		?>
		<div class = "message"><?php echo $success; ?></div>
		<?php
	}
	?>
	<h1><?php echo $heading_title; ?></h1>
	<div class="">
		<?php if (isset($faq_info)) { ?>
			<p><strong><?= $date ?></strong></p>
			<div class="faq_user_name">
			<?php echo $user_name; ?>
			</div>
			<div class="faq_question">
			<?php echo $description; ?>
			</div>
			<div class="faq_answerer_name">
			<?php echo $answerer_name; ?>
			</div>
			<div class="faq_answer">
			<?php echo $answer; ?>
			</div>
			<div class="buttons" style="clear: both">
				<div class="left">
					<a onclick="location='<?php echo $faq; ?>'"class="button"><span><?php echo $button_faq; ?></span></a>
				</div>
				<div class="right">
					<a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a>
				</div>
			</div>
			<script type="text/javascript"><!--
				$(document).ready(function () {
					$('.colorbox').colorbox({
						overlayClose: true,
						opacity: 0.5,
						rel: "colorbox"
					});
				});
			//--></script>
		<?php } ?>
	</div>
</div>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>