const progressContainer = document.getElementById("progressContainer");
const progressBar = document.getElementById("progressBar");
const progressText = document.getElementById("progressText");

const downloadBtn = document.getElementById("downloadBtn");
const pdfContainer = document.getElementById("pdfContainer");
const uploadContainer = document.getElementById("uploadContainer");

const inputContainer = document.getElementById("inputContainer");
const inputScaleFactor = document.getElementById("scaleFactor");
const inputStartPage = document.getElementById("startPage");
const inputEndPage = document.getElementById("endPage");
const inputTolerance = document.getElementById("tolerance");

/**
 * If multiple files selected:
 * - Don't display converted PDF in browser.
 * - Enable auto-downlod.
 */
let multipleInput;

document.getElementById("fileInput").onchange = handleUpload;

document.body.ondrop = handleUpload;
document.body.ondragover = (event) => event.preventDefault();

function handleDownload(name, bytes) {
  if (!bytes) return;
  const blob = new Blob([bytes], { type: "application/pdf" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(blob);
  link.download = `${name}_dark_mode.pdf`;
  link.click();
  downloadBtn.style.display = "none";
}

function handleUpload(event) {
  event.preventDefault();
  const files = event.dataTransfer ? event.dataTransfer.files : event.target.files;
  multipleInput = files.length > 1;
  for (const file of files) handleFile(file);
}

function handleFile(file) {
  if (file.type !== "application/pdf") return;
  const fileReader = new FileReader();
  fileReader.onload = async function () {
    await renderPDF(file.name, new Uint8Array(this.result));
  };
  fileReader.readAsArrayBuffer(file);
}

function minmax(value, min, max) {
  return Math.min(Math.max((isNaN(value) ? 0 : value), isNaN(min) ? max : min), max);
}

async function renderPDF(fileName, pdfData) {
  const pdf = await pdfjsLib.getDocument({ data: pdfData }).promise;
  const pdfDoc = await PDFLib.PDFDocument.create();

  const pageScale = minmax(inputScaleFactor.valueAsNumber, 1, 5);
  const pageStart = minmax(inputStartPage.valueAsNumber, 1, pdf.numPages);
  const pageEnd = minmax(inputEndPage.valueAsNumber, inputEndPage.valueAsNumber, pdf.numPages);
  const tLow = minmax(inputTolerance.valueAsNumber, 0, 255);
  const tHigh = 255 - tLow;

  if (pageEnd < pageStart) return;

  inputContainer.style.display = "none";
  progressContainer.style.display = "block";

  for (let i = pageStart; i <= pageEnd; i++) {
    progressBar.style.width = `${i / pageEnd * 100}%`;
    progressText.innerText = (i === pageEnd) ? "Finalizing..." : `${i}/${pageEnd}`;

    const page = await pdf.getPage(i);
    const viewport = page.getViewport({ scale: pageScale });
    const canvas = document.createElement("canvas");
    const canvasContext = canvas.getContext("2d");

    canvas.width = viewport.width;
    canvas.height = viewport.height;

    await page.render({ canvasContext, viewport }).promise;

    // Apply dark mode effect
    const imageData = canvasContext.getImageData(0, 0, canvas.width, canvas.height);
    const data = imageData.data;

    if (tLow === 0) {
      for (let j = 0; j < data.length; j += 4) {
        data[j] = 255 - data[j] + 25;
        data[j + 1] = 255 - data[j + 1] + 25;
        data[j + 2] = 255 - data[j + 2] + 25;
      }
    } else {
      for (let j = 0; j < data.length; j += 4) {
        const r = data[j];
        const g = data[j + 1];
        const b = data[j + 2];
        if ((r <= tLow && g <= tLow && b <= tLow) || (r >= tHigh && g >= tHigh && b >= tHigh)) {
          data[j] = 255 - r + 25;
          data[j + 1] = 255 - g + 25;
          data[j + 2] = 255 - b + 25;
        }
      }
    }

    canvasContext.putImageData(imageData, 0, 0);
    if (!multipleInput) pdfContainer.appendChild(canvas);

    // Convert modified canvas to PNG and add to PDF
    const imgBytes = await new Promise((resolve) => {
      canvas.toBlob((blob) => blob.arrayBuffer().then(resolve), "image/png");
    });
    const jpgImage = await pdfDoc.embedPng(imgBytes);
    const newPage = pdfDoc.addPage([viewport.width, viewport.height]);
    newPage.drawImage(jpgImage, {
      x: 0, y: 0,
      width: viewport.width,
      height: viewport.height,
    });
  }

  progressContainer.style.display = "none";

  const name = fileName.replace(/\.pdf$/i, "");
  const bytes = await pdfDoc.save();

  if (multipleInput) {
    handleDownload(name, bytes);
  } else {
    downloadBtn.style.display = "inline-block";
    downloadBtn.onclick = (_) => handleDownload(name, bytes);
  }
}
