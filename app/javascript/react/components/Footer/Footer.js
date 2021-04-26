import React from 'react';

const Footer = () => {
  return (
    <footer className='footer'>
      <div className='container d-flex justify-content-between'>
        <ul className='nav m-3'>
          <li className='nav-link'>© 2021 Heath Tracker</li>
          <li className='nav-link'>
            <a href='#'>Contact Us</a>
          </li>
          <li className='nav-link'>
            <a href='#'>About Us</a>
          </li>
          <li className='nav-link'>
            <a href='#'>Terms</a>
          </li>
          <li className='nav-link'>
            <a href='#'>Privacy</a>
          </li>
          <li className='nav-link'>
            <a href='#'>Site Map</a>
          </li>
        </ul>
        <ul className='nav m-3'>
          <li className='nav-link text-secondary'>
            <i className='fas fa-map-marker-alt'></i>
            Built in Melbourne
          </li>
          <li className='nav-link' target='_blank'>
            <a
              href='https://github.com/failure-driven/health-tracker'
              alt='Github'
            >
              <i className='fab fa-github'></i>
            </a>
          </li>
        </ul>
      </div>
    </footer>
  );
};

export default Footer;
