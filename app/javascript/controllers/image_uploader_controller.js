import { Dropzone } from "dropzone";
import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
import { getMetaValue, toArray, findElement, removeElement, insertAfter } from "../helpers/index";

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = this.createDirectUpload(file, source.url);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if (error) {
        removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
      }
    });
  }

  createHiddenInput() {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    insertAfter(input, this.source.inputTarget);
    return input;
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr);
    this.emitDropzoneUploading();
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", event =>
      this.uploadRequestDidProgress(event)
    );
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file);
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error);
    this.source.dropZone.emit("complete", this.file);
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file);
    this.source.dropZone.emit("complete", this.file);
  }

  createDirectUpload(file, url) {
    return new DirectUpload(file, url, this);
  }
}

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.dropZone = this.createDropZone();
    this.hideFileInput();
    this.bindEvents();
    Dropzone.autoDiscover = false; // necessary quirk for Dropzone error in console

    this.importExistingFiles();
  }

  // Private
  hideFileInput() {
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = "none";
  }

  bindEvents() {
    this.dropZone.on("addedfile", file => {
      setTimeout(() => {
        file.accepted && this.createDirectUploadController(file).start();
      }, 500);
    });

    this.dropZone.on("removedfile", file => {
      file.controller && removeElement(file.controller.hiddenInput);
    });

    this.dropZone.on("canceled", file => {
      file.controller && file.controller.xhr.abort();
    });
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 1;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }

  createDirectUploadController(file) {
    return new DirectUploadController(this, file);
  }

  createDropZone() {
    return new Dropzone(this.element, {
      url: this.url,
      headers: this.headers,
      maxFiles: this.maxFiles,
      maxFilesize: this.maxFileSize,
      acceptedFiles: this.acceptedFiles,
      addRemoveLinks: this.addRemoveLinks,
      autoQueue: false,
      dictFileTooBig: "File is too big ({{filesize}}mb). Max allowed file size is {{maxFilesize}}mb",
      dictInvalidFileType: "Invalid File Type",
      dictCancelUpload: "Cancel",
      dictRemoveFile: "Remove",
      dictMaxFilesExceeded: "Only {{maxFiles}} files are allowed",
      dictDefaultMessage: "Drop files here to upload",
    });
    // Todo : Make translation work with I18n.js
  }

  importExistingFiles() {
    jsonMedia.forEach((image) => {
      let input = Object.assign(document.createElement("input"), {type: "hidden", name: "room[images][]", value: image.id});

      this.inputTarget.insertAdjacentElement("afterend", input);
      image.controller = { hiddenInput: input };
console.log(this);
console.log(image);
      this.dropZone.displayExistingFile(image, image.name);
    });
  }
}
