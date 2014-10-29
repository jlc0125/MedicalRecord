$(function() {
	$("#edit_sticker_a").click(function() {
		$("#sticker_edit_modal").modal("show");

	});

	$("#fileupload").uploadify({
		'auto' : false,
		'fileObjName' : 'filedata',
		'swf' : '../resources/exlib/uploadify/uploadify.swf',
		'uploader' : './file',
		'fileTypeExts' : '*.jpg;*.jpge;*.gif;*.png',
		'queueSizeLimit' : 1,
		'buttonText' : '选择图片',
		// 选择上传文件后调用
		'onSelect' : function(file) {
		},
		'onUploadStart' : function(file) {
		},
		'onCancel' : function(file) {
		},
		// 上传到服务器，服务器返回相应信息到data里
		'onUploadSuccess' : function(file, data, response) {
			uploadFileSuccess(file, data, response);
		},
		'onUploadError' : function(file, errorCode, errorMsg, errorString) {
			uploadFileError(file, errorCode, errorMsg, errorString);
		}
	});

	$("#upload_file_btn").click(uploadFile);

	$(".close").click(cancel);
});
/**
 * 取消选中的图片
 */
function cancel() {
	$('#fileupload').uploadify('cancel', '*');
}
/**
 * 开始上传图片文件
 */
function uploadFile() {
	// start to upload
	$('#fileupload').uploadify('upload', '*');
}
/**
 * upload file successfully
 * 
 * @param file
 * @param data
 *            string
 * @param response
 */
function uploadFileSuccess(file, dataString, response) {
	var data = JSON.parse(dataString);
	if (true == data.flag) {
		$("#sticker_img_src").attr("src", data.selfpic);
		alert("123");
	} else {
	}
}
/**
 * fail to upload file
 * 
 * @param file
 * @param errorCode
 * @param errorMsg
 * @param errorString
 */
function uploadFileError(file, errorCode, errorMsg, errorString) {
	print(errorMsg);
}