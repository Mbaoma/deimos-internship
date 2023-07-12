"use strict";
const express = require('express');
const fs = require('fs');

const app = express();
const port = 8080;

// Define the route to serve image files
// app.use('/images', express.static('./images'));

app.use('/css', express.static('main.css'));

app.get('/', (req, res) => {
  // Read the HTML file
  fs.readFile('index.html', 'utf8', (err, data) => {
    if (err) {
      res.status(500).send('Internal Server Error');
      return;
    }
    

    // Generate the dynamic content
    const generatedContent = generateAnimeList();

    // Replace a placeholder in the HTML file with the generated content
    const modifiedHTML = data.replace('{{animeList}}', generatedContent);

    // Set the response headers
    res.setHeader('Content-Type', 'text/html');

    // Send the modified HTML as the response
    res.send(modifiedHTML);
  });
});

// Handle other routes
app.use((req, res) => {
  res.status(404).send('Not Found');
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

function generateAnimeList() {
    const animeList = [
        { title: 'The Rising of the Shield Hero Season 3', releasedate: 'October 2023', image: '/images/shield.webp' },
        { title: 'Spy x Family Season 2', releasedate: 'October 2023', image: '/images/spy.jpeg' },
        { title: 'The Eminence in Shadow Season 2', releasedate: 'October 2023', image: '/images/eminence.jpeg' },
        { title: 'Tokyo Revengers: Tenjiku-hen', releasedate: 'October 2023', image: '/images/tokyo.jpeg' },
        { title: 'The Faraway Paladin Season 2', releasedate: 'July 1', image: '/images/faraway.jpeg' },
    ];

  let generatedContent = '';

  animeList.forEach(anime => {
    generatedContent += `
      <div class="anime-card">
        <img src="${anime.image}" alt="${anime.title}">
        <h3>${anime.title}</h3>
        <p>${anime.releasedate}</p>
      </div>
    `;
  });

  return generatedContent;
}

// "use strict";
// const express = require('express');
// const fs = require('fs');

// const app = express();
// const port = 8080;

// app.use('/css', express.static('main.css'));

// app.get('/', (req, res) => {
//   // Read the HTML file
//   fs.readFile('index.html', 'utf8', (err, data) => {
//     if (err) {
//       res.status(500).send('Internal Server Error');
//       return;
//     }

//     // Set the response headers
//     res.setHeader('Content-Type', 'text/html');

//   });
// });

// // Handle other routes
// app.use((req, res) => {
//   res.status(404).send('Not Found');
// });

// // Start the server
// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });
