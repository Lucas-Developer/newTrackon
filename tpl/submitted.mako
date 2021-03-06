<%! from time import time %>
<%inherit file="base.mako"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js" integrity="sha256-1hjUhpc44NwiNg8OwMu2QzJXhD8kcj+sJA3aCQZoUjg=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/livestamp/1.1.2/livestamp.min.js" integrity="sha256-8r65KJgULBDiZhwDydfWrEkx3yyV/grGsGzaekobngI=" crossorigin="anonymous"></script>
<div class="container">
  <h2>Log of Newly Submitted Trackers</h2>
  <p>This is the information about the last 300 tried trackers. To make it to the queue, a tracker has to be a well-formed URL, not to be an IP, and resolve at least to an IPv4
    address.</p>
    <p>Every tracker to reach the queue is tried (in this order) with UDP, HTTPS and HTTP. When one protocol succeeds, and if its update interval is between 5 minutes and 3 hours,
      it gets added to the list. If no port is specified, the tracker is tried only with HTTPS on port 443 and HTTP on port 80.</p>
      <p>The queue is processed at about 10 seconds per URL tried.</p>
      <p><b>Number of trackers in the queue: ${size}</b></p>
    </div>
    % if data:
    <div class="container-fluid">
      <div class="table-responsive">
        <table class="sortable table table-responsive table-striped table-bordered initially-hidden">
          <thead>
            <tr>
              <th>Time</th>
              <th>URL</th>
              <th>IP</th>
              <th>Result</th>
              <th>Response/Error</th>
            </tr>
          </thead>
          % for response in data:
          <tr>
            <td><span data-livestamp="${response['time']}"></span></td>
            <td>${response['url']}</td>
            <td>${response.get('ip', '')}</td>
            % if response['status'] == 1:
            <td class="up"><b>Accepted</b></td>
            % else:
            <td class="rejected"><b>Rejected</b></td>
            % endif
            <td>${response['info']}</td>
          </tr>
          % endfor

          % endif
        </table>
      </div>
    </div>
    <script>
    $(document).ready(function() {
        $(".initially-hidden").css("visibility", "visible");
    });
    </script>
    <%def name="title()">Submitted Trackers - newTrackon</%def>
